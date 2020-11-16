#!/bin/sh

set -eu

if test -f /run/disarm-canary-binaries; then
	exec $(realpath -e $0).nocanary $@
fi

# Kick this off in the background so it doesn't slow down the real binary's execution
echo '{{ bin_desc }} canary triggered. Possible security violation. Report is being prepared and mailed.' | systemd-cat -p warning -t '{{ bin_desc }} canary output' mail 7607054581@tmomail.net

# TODO exec 2>&1, then restore afterwards

# TODO maybe do this stuff all the way up to init?

cd $(mktemp -d)
env > env.txt
cat /proc/$$/cmdline > this_cmdline.txt
cat /proc/$PPID/cmdline > parent_cmdline.txt
ls -l /proc/$PPID/fd > parent_fds.txt
pstree -acglpStuZ >pstree-acglpStuZ.txt 2>&1
echo $$ > this_pid.txt
echo $PPID > parent_pid.txt
journalctl -xn >journalctl-xn.txt 2>&1
file -Lkb /proc/$PPID/fd/* > parent-fds-file-Lkb.txt
gcore -a $PPID >gcore-output.txt 2>&1
getpcaps $PPID >parent-getpcaps.txt 2>&1
cp /proc/$PPID/maps parent_maps.txt

# Search for textual fds owned by the parent process
for i in /proc/$PPID/fd/*; do
	if echo $(file -Lib $i) | grep -q text; then
		cp $i parent_fd_$(basename $i).txt
	fi

	# TODO make this detect deleted fds (suspicious) and attach those too
done

# Search for filenames passed as args
for i in $@; do
	if test -e "$OLDPWD"/"$i"; then
		cp "$OLDPWD"/"$i" args_file_$(basename "$i")
	fi
done

ATTACH_ARGS=''
for i in *; do
	ATTACH_ARGS="$ATTACH_ARGS --content-type=$(file -b --mime-type $i) -A $i"
done

# TODO this is sending the heredoc as an attachment for some reason
mail -s '[SECURITY] Suspicious {{ bin_desc }} invocation' $ATTACH_ARGS --content-type=text/plain security@strugee.net ajord17@u.rochester.edu <<EOF
A canary-armed {{ bin_desc }} binary was triggered on host $(hostname -f) $(date) by user $(whoami).

This likely represents a security violation, so this should be investigated yesterday. Alternately, a system component does not know to use the .nocanary {{ bin_desc }} binary, but this is unlikely.

The current working directory is $OLDPWD. More details are attached.
EOF

cd - >/dev/null
rm -rf $OLDPWD # The /tmp dir

# TODO: make gcc think it's being invoked with the name in $0

exec $(realpath -e $0).nocanary $@
