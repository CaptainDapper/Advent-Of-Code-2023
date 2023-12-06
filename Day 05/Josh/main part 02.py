from sys import maxsize
import threading

from MapSet import MapSet
from MapSetEnum import MapSetTypeEnum, GetMapSetTypeEnum
from range import Range
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

# mapSet.print_maps()
# print (seedArray)
# print (seedArray[0], mapSet.locationValue(seedArray[0]))
# locations = []
# for i in seedArray:
#     locations.append(mapSet.locationValue(i))
     # print (i, mapSet.locationValue(i))

# get min value from locatins
#print (min(locations))

print ("Processing... Please wait...")
location = maxsize
# print(location)
# print (seedArray)
size = len(seedArray)
# print (len(seedArray))

# Create a lock to synchronize access to the shared location variable
location_lock = threading.Lock()

def process_range(start, length):
    global location
    r = Range(start, -1, length)
    print(F"Processing {r}")
    for j in r.get_source_values():
        with location_lock:
            v = mapSet.locationValue(j)
            if location > v:
                location = v

# Create a list to hold the thread objects
threads = []

highest = 0
totalRecs = 0
# Create and start a thread for each seed range
for i in range(0, size, 2):
    seedStart = seedArray[i]
    seedLength = seedArray[i + 1]

    for j in range(seedStart, seedStart + seedLength):
        pass              




#     for j in range(seedStart, seedStart + seedLength, arraySize):
#         l = arraySize
#         if j + l > seedStart + seedLength:
#             l = seedStart + seedLength - j

#         t = threading.Thread(target=process_range, args=(j, l))
#         threads.append(t)
#         t.start()

# # Wait for all threads to complete
# for t in threads:
#     t.join()

# print(location)




