from typing import List
from range import Range
from MapSetEnum import MapSetTypeEnum

class Map:

    def __init__(self, map_set_type: MapSetTypeEnum):
        self.ranges: List[Range] = []
        self.map_set_type = map_set_type

    def __str__(self):
        return '\n'.join([str(r) for r in self.ranges])
    
    def add_range(self, str):
        parts = str.split(' ')
        source_start = int(parts[0])
        dest_start = int(parts[2])
        length = int(parts[4])
        self.ranges.append(Range(source_start, dest_start, length))
    