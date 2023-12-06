from MapSet import MapSet
from MapSetEnum import MapSetTypeEnum, GetMapSetTypeEnum
from helpers import ReadFile, GetSeedsArray, GetNumberArray

# Open the file in read mode
# content = ReadFile('day 05\\josh\\test.txt')
content = ReadFile('day 05\\josh\\input.txt')

mapSet = MapSet()
seedArray = []
currentMapType = MapSetTypeEnum.NONE

for i in content:
    i = i.replace('\n', '')

    i = i.strip()
    if (i == ""):
        continue

    if "seeds:" in i:
        seedArray = GetSeedsArray(i)
        continue

    nextMapType = GetMapSetTypeEnum(i)
    if(nextMapType != MapSetTypeEnum.NONE):
        currentMapType = nextMapType
        continue    
    mapSet.get_map(currentMapType).add_range(i)

mapSet.print_maps()
# print (seedArray)
# print (seedArray[0], mapSet.locationValue(seedArray[0]))
locations = []
for i in seedArray:
    locations.append(mapSet.locationValue(i))
    # print (i, mapSet.locationValue(i))

# get min value from locatins
print (min(locations))
   

