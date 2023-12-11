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
        self.start_tile = None
        self.PopulateTiles()
        self.PopulateExits()
        self.PopulateStartExits()
        self.PopulateDistanceFromStart()
        font.init()
        self.textFont = font.Font(font.get_default_font(), 8)

    def PopulateTiles(self):
        for y in range(len(self.data)):            
            row = self.data[y]
            for x in range(len(row)):
                newTile = Tile(x, y, row[x])
                self.tiles.append(newTile)
                self.tile_map[(x, y)] = newTile
                if newTile.is_start:
                    self.start_tile = newTile

    def PopulateDistanceFromStart(self):
        valid_directions = self.start_tile.get_valid_directions()
        for direction in valid_directions:
            self.TravelFromStart(direction)

    def TravelFromStart(self, direction):
        stepsTaken = 0
        self.start_tile.distance_from_start = stepsTaken
        # self.start_tile.PrintExits()
        direction = self.start_tile.get_forward_direction(direction)
        # print (f'forward direction: {direction}')
        if direction is None:
            return
        cTile = self.start_tile.get_forward_tile(direction)
        # cTile.Print()
        if cTile is None:
            return        
        while cTile.is_start == False:
            stepsTaken += 1
            if cTile.distance_from_start is None:
                cTile.distance_from_start = stepsTaken
            elif cTile.distance_from_start > stepsTaken:
                cTile.distance_from_start = stepsTaken

            direction = cTile.get_forward_direction(direction)
            # print (f'forward direction: {direction}')
            if direction is None:
                return
            cTile = cTile.get_forward_tile(direction)
            # cTile.Print()


    def GetTile(self, x, y):
        if x < 0 or x >= self.max_x or y < 0 or y >= self.max_y:
            return None
        return self.tile_map[(x, y)]

    def PopulateExits(self):
        for tile in self.tiles:
            directions = GetAllowedDirections(tile.value)
            for direction in directions:
                if direction == DirectionEnum.UP:
                    tile.exit_map[DirectionEnum.UP] = self.GetTile(tile.x, tile.y - 1)
                elif direction == DirectionEnum.RIGHT:
                    tile.exit_map[DirectionEnum.RIGHT] = self.GetTile(tile.x + 1, tile.y)
                elif direction == DirectionEnum.DOWN:
                    tile.exit_map[DirectionEnum.DOWN] = self.GetTile(tile.x, tile.y + 1)
                elif direction == DirectionEnum.LEFT:
                    tile.exit_map[DirectionEnum.LEFT] = self.GetTile(tile.x - 1, tile.y)
    
    def PopulateStartExits(self):
        self.CheckStartExit(DirectionEnum.UP, DirectionEnum.DOWN)
        self.CheckStartExit(DirectionEnum.RIGHT, DirectionEnum.LEFT)
        self.CheckStartExit(DirectionEnum.DOWN, DirectionEnum.UP)
        self.CheckStartExit(DirectionEnum.LEFT, DirectionEnum.RIGHT)

    def CheckStartExit(self, exit_start, exit_next):
        tile = self.start_tile.exit_map[exit_start]
        if tile is None:
            self.start_tile.exit_map[exit_start] = None
            return
        if tile.exit_map[exit_next] is None:
            self.start_tile.exit_map[exit_start] = None
            return
        return


    def print(self):
        for y in range(len(self.data)):
            for x in range(len(self.data[y])):
                print(self.data[y][x], end='')
            print()            
        
    def draw_to_file(self, tic, filename):
        screen = Surface((self.max_x * 32, self.max_y * 32), 0, 32)
        fg = (255, 255, 255)
        for tile in self.tiles:
            text = self.textFont.render(str(tile.distance_from_start), False, fg)
            tileImage = tic.getTileImage(tile.value)
            tileImage.sprite.rect.x = tile.x * 32
            tileImage.sprite.rect.y = tile.y * 32
            screen.blit(tileImage.sprite.image, tileImage.sprite.rect)
            screen.blit(text, ((tile.x * 32) + 2, (tile.y * 32) + 2))

        image.save(screen, filename)