# add paths of the directories where your photos live.
# it will not look for photos recursively, so you might want to add subdirectories as well.
import os

image_dirs = [
    '/srv/http/librephotos/photos'

]

mapzen_api_key = 'take_care_of_me'
mapbox_api_key = os.environ['MAPBOX_API_KEY']
