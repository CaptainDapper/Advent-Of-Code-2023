from tile import Tile
from tile_enums import DirectionEnum, GetAllowedDirections
from tile_image_collection import TileImageCollection
from pygame import image, Surface, font

class TileCollection:

    def __init__(self, data):
        self.tiles = []
        self.tile_map = { }
        self.data = data
        self.max_x = len(data[0])
        self.max_y = len(data)
        self.PopulateTiles()
        self.PopulateExits()
        font.init()
        self.textFont = font.Font(font.get_default_font(), 8)

    def PopulateTiles(self):
        for y in range(len(self.data)):            
            row = self.data[y]
            for x in range(len(row)):
                newTile = Tile(x, y, row[x])
                self.tiles.append(newTile)

    def CaluclateTileMap(self):
        self.tile_map = { }                             # Clear the tile map
        for tile in self.tiles:                         # Rebuild the tile map
            self.tile_map[(tile.x, tile.y)] = tile      # Add the tile to the map

    def GetTile(self, x, y):
        if x < 0 or x >= self.max_x or y < 0 or y >= self.max_y:
            return None
        return self.tile_map[(x, y)]

    def PopulateExits(self):
        self.CaluclateTileMap()                                                                 # Build the tile map
        for tile in self.tiles:                                                                 # For each tile                          
            directions = GetAllowedDirections(tile.value)                                       # Get the allowed directions
            for direction in directions:                                                        # For each allowed direction
                if direction == DirectionEnum.UP:
                    tile.exit_map[DirectionEnum.UP] = self.GetTile(tile.x, tile.y - 1)
                elif direction == DirectionEnum.RIGHT:
                    tile.exit_map[DirectionEnum.RIGHT] = self.GetTile(tile.x + 1, tile.y)
                elif direction == DirectionEnum.DOWN:
                    tile.exit_map[DirectionEnum.DOWN] = self.GetTile(tile.x, tile.y + 1)
                elif direction == DirectionEnum.LEFT:
                    tile.exit_map[DirectionEnum.LEFT] = self.GetTile(tile.x - 1, tile.y)
    

    def print(self):
        for y in range(len(self.data)):
            for x in range(len(self.data[y])):
                print(self.data[y][x], end='')
            print()            
        
    def draw_to_file(self, tic, filename):
        screen = Surface((self.max_x * 32, self.max_y * 32), 0, 32)
        fg = (255, 255, 255)
        for tile in self.tiles:
            # text = self.textFont.render(str(tile.distance_from_start), False, fg)
            tileImage = tic.getTileImage(tile.value)
            tileImage.sprite.rect.x = tile.x * 32
            tileImage.sprite.rect.y = tile.y * 32
            screen.blit(tileImage.sprite.image, tileImage.sprite.rect)
            # screen.blit(text, ((tile.x * 32) + 2, (tile.y * 32) + 2))

        image.save(screen, filename)