from enum import Enum

class MapSetTypeEnum(Enum):
    NONE = 0
    SEED_TO_SOIL = 1
    SOIL_TO_FERTILIZER = 2
    FERTILIZER_TO_WATER = 3
    WATER_TO_LIGHT = 4
    LIGHT_TO_TEMPERATURE = 5
    TEMPERATURE_TO_HUMIDITY = 6
    HUMIDITY_TO_LOCATION = 7

def GetMapSetTypeEnum(str):
    switcher = {
        "seed-to-soil map:": MapSetTypeEnum.SEED_TO_SOIL,
        "soil-to-fertilizer map:": MapSetTypeEnum.SOIL_TO_FERTILIZER,
        "fertilizer-to-water map:": MapSetTypeEnum.FERTILIZER_TO_WATER,
        "water-to-light map:": MapSetTypeEnum.WATER_TO_LIGHT,
        "light-to-temperature map:": MapSetTypeEnum.LIGHT_TO_TEMPERATURE,
        "temperature-to-humidity map:": MapSetTypeEnum.TEMPERATURE_TO_HUMIDITY,
        "humidity-to-location map:": MapSetTypeEnum.HUMIDITY_TO_LOCATION
    }

    return switcher.get(str, MapSetTypeEnum.NONE)