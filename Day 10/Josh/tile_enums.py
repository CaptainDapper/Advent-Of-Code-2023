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
    if value == '7':
        return [DirectionEnum.DOWN, DirectionEnum.LEFT]
    elif value == 'F':
        return [DirectionEnum.DOWN, DirectionEnum.RIGHT]
    elif value == '|':
        return [DirectionEnum.UP, DirectionEnum.DOWN]
    elif value == 'J':
        return [DirectionEnum.LEFT, DirectionEnum.UP]
    elif value == 'L':
        return [DirectionEnum.RIGHT, DirectionEnum.UP]
    elif value == '-':
        return [DirectionEnum.LEFT, DirectionEnum.RIGHT]
    elif value == '.':
        return []
    elif value == 'S':
        return [DirectionEnum.UP, DirectionEnum.RIGHT, DirectionEnum.DOWN, DirectionEnum.LEFT]
    else:
        raise Exception('Unknown value: ' + value)