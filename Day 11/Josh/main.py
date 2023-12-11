from helpers import ReadFile
from tile_collection import TileCollection
from tile_image_collection import TileImageCollection
from icecream import ic


# Open the file in read mode
content = ReadFile('day 11\\josh\\test.txt')
# content = ReadFile('day 11\\josh\\input.txt')

# Create a new instance of TileImageCollection
tic = TileImageCollection('day 11\\josh\\sprites\\')


# Create a new instance of TileCollection
tc = TileCollection(content)
tc.draw_to_file(tic, 'day 11\\josh\\test.png')
# tc.draw_to_file(tic, 'day 11\\josh\\input.png')

tc.print()

