from map import Map
from MapSetEnum import MapSetTypeEnum

class MapSet:
    def __init__(self):
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
        idx = map_set_type.value
        return self.maps[idx]

    def print_maps(self):
        for m in self.maps:
            print (m)
    
    def locationValue(self, seedValue):
        # print (f'seedValue: {seedValue}')        
        location = self.get_map(MapSetTypeEnum.SEED_TO_SOIL).get_from_cache(seedValue)
        if location != None:
            return location
        soil = self.get_map(MapSetTypeEnum.SEED_TO_SOIL).get_value(seedValue)

        location = self.get_map(MapSetTypeEnum.SOIL_TO_FERTILIZER).get_from_cache(soil)
        if location != None:
            return location        
        fertilizer = self.get_map(MapSetTypeEnum.SOIL_TO_FERTILIZER).get_value(soil)

        location = self.get_map(MapSetTypeEnum.FERTILIZER_TO_WATER).get_from_cache(fertilizer)
        if location != None:
            return location
        water = self.get_map(MapSetTypeEnum.FERTILIZER_TO_WATER).get_value(fertilizer)

        location = self.get_map(MapSetTypeEnum.WATER_TO_LIGHT).get_from_cache(water)
        if location != None:
            return location    
        light = self.get_map(MapSetTypeEnum.WATER_TO_LIGHT).get_value(water)

        location = self.get_map(MapSetTypeEnum.LIGHT_TO_TEMPERATURE).get_from_cache(light)
        if location != None:
            return location
        temperature = self.get_map(MapSetTypeEnum.LIGHT_TO_TEMPERATURE).get_value(light)

        location = self.get_map(MapSetTypeEnum.TEMPERATURE_TO_HUMIDITY).get_from_cache(temperature)
        if location != None:
            return location        
        humidity = self.get_map(MapSetTypeEnum.TEMPERATURE_TO_HUMIDITY).get_value(temperature)


        location = self.get_map(MapSetTypeEnum.HUMIDITY_TO_LOCATION).get_value(humidity)

        self.get_map(MapSetTypeEnum.SEED_TO_SOIL).cache_location_value(seedValue, location)
        self.get_map(MapSetTypeEnum.SOIL_TO_FERTILIZER).cache_location_value(soil, location)
        self.get_map(MapSetTypeEnum.FERTILIZER_TO_WATER).cache_location_value(fertilizer, location)
        self.get_map(MapSetTypeEnum.WATER_TO_LIGHT).cache_location_value(water, location)
        self.get_map(MapSetTypeEnum.LIGHT_TO_TEMPERATURE).cache_location_value(light, location)
        self.get_map(MapSetTypeEnum.TEMPERATURE_TO_HUMIDITY).cache_location_value(temperature, location)
        self.get_map(MapSetTypeEnum.HUMIDITY_TO_LOCATION).cache_location_value(humidity, location)

        return location

    
