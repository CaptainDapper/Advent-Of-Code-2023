from enum import Enum

class DirectionEnum(Enum):
    UP = 0
    RIGHT = 1
    DOWN = 2
    LEFT = 3

def GetBackwardsDirection(direction):
    if direction == DirectionEnum.UP:
        return DirectionEnum.DOWN
    elif direction == DirectionEnum.RIGHT:
        return DirectionEnum.LEFT
    elif direction == DirectionEnum.DOWN:
        return DirectionEnum.UP
    elif direction == DirectionEnum.LEFT:
        return DirectionEnum.RIGHT
    else:
        raise Exception('Unknown direction: ' + direction)

def GetAllowedDirections(value):
    if value == None:
        return []
    return [DirectionEnum.UP, DirectionEnum.RIGHT, DirectionEnum.DOWN, DirectionEnum.LEFT]    
