from tile_enums import DirectionEnum

class Tile:
    def __init__(self, x, y, value):
        self.x = x
        self.y = y
        self.value = value
        self.exit_map = { DirectionEnum.UP: None, DirectionEnum.RIGHT: None, DirectionEnum.DOWN: None, DirectionEnum.LEFT: None }

    def Print(self):
        print('Tile at ({0}, {1}) is {2}'.format(self.x, self.y, self.value))
    def PrintExits(self):
        print('Tile at ({0}, {1}) has exits:'.format(self.x, self.y))
        for direction in self.exit_map:
            print('  {0}: {1}'.format(direction, self.exit_map[direction]))
        print('')

    def get_valid_directions(self):
        return [direction for direction in self.exit_map if self.exit_map[direction] is not None]