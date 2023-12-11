from helpers import ReadFile
from tile_collection import TileCollection
from tile_image_collection import TileImageCollection
from icecream import ic


# Open the file in read mode
# content = ReadFile('day 10\\josh\\test.txt')
content = ReadFile('day 10\\josh\\input.txt')

# Create a new instance of TileImageCollection
tic = TileImageCollection('day 10\\josh\\sprites\\')


# Create a new instance of TileCollection
tc = TileCollection(content)
# tc.draw_to_file(tic, 'day 10\\josh\\test.png')
tc.draw_to_file(tic, 'day 10\\josh\\input.png')

tc.print()
tc.start_tile.PrintExits()

#Find the tile in tc.tiles with the largest distance_from_start
max_distance = 0
max_tile = None
for tile in tc.tiles:
    if tile.distance_from_start is not None and tile.distance_from_start > max_distance:
        max_distance = tile.distance_from_start
        max_tile = tile

print(f'The furthest tile from the start is {max_tile.value} at ({max_tile.x}, {max_tile.y}) with a distance of {max_tile.distance_from_start}')