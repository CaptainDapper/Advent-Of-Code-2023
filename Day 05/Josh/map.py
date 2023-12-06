from typing import List
from range import Range
from MapSetEnum import MapSetTypeEnum

class Map:

    

    def __init__(self, map_set_type: MapSetTypeEnum):
        self.ranges: List[Range] = []
        self.map_set_type = map_set_type
        self.cache_location = {}

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
            ret = r.get_dest_value(value)
            if ret != None:
                return ret            
        return value
    
    def get_from_cache(self, value):
        if value in self.cache_location:
            return self.cache_location[value]
        return None

    def cache_location_value(self, value, location):        
        self.cache_location[value] = location
        pass
    