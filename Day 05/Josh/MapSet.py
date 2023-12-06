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
        soil = self.get_map(MapSetTypeEnum.SEED_TO_SOIL).get_value(seedValue)
        # print (f'soil: {soil}')
        fertilizer = self.get_map(MapSetTypeEnum.SOIL_TO_FERTILIZER).get_value(soil)
        # print (f'fertilizer: {fertilizer}')
        water = self.get_map(MapSetTypeEnum.FERTILIZER_TO_WATER).get_value(fertilizer)
        # print (f'water: {water}')
        light = self.get_map(MapSetTypeEnum.WATER_TO_LIGHT).get_value(water)
        # print (f'light: {light}')
        temperature = self.get_map(MapSetTypeEnum.LIGHT_TO_TEMPERATURE).get_value(light)
        # print (f'temperature: {temperature}')
        humidity = self.get_map(MapSetTypeEnum.TEMPERATURE_TO_HUMIDITY).get_value(temperature)
        # print (f'humidity: {humidity}')
        location = self.get_map(MapSetTypeEnum.HUMIDITY_TO_LOCATION).get_value(humidity)
        # print (f'location: {location}')
        return location

    
