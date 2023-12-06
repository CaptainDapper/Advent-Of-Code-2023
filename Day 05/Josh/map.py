from typing import List
from range import Range
from MapSetEnum import MapSetTypeEnum

class Map:

    def __init__(self, map_set_type: MapSetTypeEnum):
        self.ranges: List[Range] = []
        self.map_set_type = map_set_type

    def __str__(self):
        ret = f'{self.map_set_type.name}\n'
        for r in self.ranges:
            ret += f'{r}\n'
        return ret
    
    def add_range(self, str):
        parts = str.split(' ')
        source_start = int(parts[1])
        dest_start = int(parts[0])
        length = int(parts[2])
        self.ranges.append(Range(source_start, dest_start, length))
    
    def get_value(self, value):
        for r in self.ranges:
            if r.in_source_range(value):
                # print(f'{value} in range {r}')
                return r.get_dest_value(value)
        return value
    