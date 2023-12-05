from map import Map
from MapSetEnum import MapSetTypeEnum

class MapSet:
    def __int__(self):
        self.maps = []
        self.maps.append(Map(MapSetTypeEnum.NONE))
        self.maps.append(Map(MapSetTypeEnum.SEED_TO_SOIL))
        self.maps.append(Map(MapSetTypeEnum.SOIL_TO_FERTILIZER))
        self.maps.append(Map(MapSetTypeEnum.FERTILIZER_TO_WATER))
        self.maps.append(Map(MapSetTypeEnum.WATER_TO_LIGHT))
        self.maps.append(Map(MapSetTypeEnum.LIGHT_TO_TEMPERATURE))
        self.maps.append(Map(MapSetTypeEnum.TEMPERATURE_TO_HUMIDITY))
        self.maps.append(Map(MapSetTypeEnum.HUMIDITY_TO_LOCATION))

    def get_map(self, map_set_type: MapSetTypeEnum):
        return self.maps[map_set_type.value]

        

    
