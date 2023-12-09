from helpers import GetNumberArray, ReadFile
from sensor import Sensor

# Open the file in read mode
# content = ReadFile('day 09\\josh\\test.txt')
# content = ReadFile('day 09\\josh\\test2.txt')
content = ReadFile('day 09\\josh\\input.txt')

sum = 0
for i in content:
    s = Sensor(i)
    s.ExtrapolatePreviousValues()
    sum += s.data[0][0]

print(sum)
