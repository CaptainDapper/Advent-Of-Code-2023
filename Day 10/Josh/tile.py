from tile_enums import DirectionEnum, GetBackwardsDirection

class Tile:
    def __init__(self, x, y, value):
        self.x = x
        self.y = y
        self.is_start = value == 'S'
        self.value = value
        self.exit_map = { DirectionEnum.UP: None, DirectionEnum.RIGHT: None, DirectionEnum.DOWN: None, DirectionEnum.LEFT: None }
        self.distance_from_start = None


    def Print(self):
        print('Tile at ({0}, {1}) is {2}'.format(self.x, self.y, self.value))
    def PrintExits(self):
        print('Tile at ({0}, {1}) has exits:'.format(self.x, self.y))
        for direction in self.exit_map:
            print('  {0}: {1}'.format(direction, self.exit_map[direction]))
        print('')

    def get_forward_direction(self, direction):
        forward = self.exit_map[direction]
        if forward is not None:
            return direction
        notAllowed = GetBackwardsDirection(direction)
        for direction in self.exit_map.keys():
            if direction == notAllowed:
                continue
            if self.exit_map[direction] is None:
                continue
            return direction
        return None

    def get_forward_tile(self, direction):
        forward = self.exit_map[direction]   # Get the forward tile
        if forward is not None:              # If there is a forward tile
            return forward                   # Return it
        
        notAllowed = GetBackwardsDirection(direction)  # Get the direction we came from
        for direction in self.exit_map:                # For each direction
            if direction == notAllowed:                # If it's the direction we came from
                continue                               # Skip it   
            if self.exit_map[direction] is None:       # If there is no tile in that direction
                continue                               # Skip it
            return self.exit_map[direction]            # Return the tile in that direction
        return None                                    # Return None if we can't find a tile

    def get_valid_directions(self):
        return [direction for direction in self.exit_map if self.exit_map[direction] is not None]