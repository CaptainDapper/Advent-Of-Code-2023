import sys
from Point2D import Point2D
from helpers import get_points_from_string_array, get_points_from_string_array_with_values, is_point_in_rectangle

# Open the file in read mode
# file = open('day 03\\josh\\test.txt', 'r')
file = open('day 03\\josh\\input.txt', 'r')

# Read the entire content of the file
content = file.readlines()

# Close the file
file.close()

# Create an array
symbols = get_points_from_string_array(content)
# symbols.append(Point2D(0,0))

# for i in symbols:
#     print(i)

values = get_points_from_string_array_with_values(content)

sum = 0
by_symbol = False
for i in values:
    by_symbol = False
    bbox = i.get_rectagle().expand(1, 1, 1, 1)
    for j in symbols:
        if is_point_in_rectangle(j, bbox):
            by_symbol = True
            break

    if by_symbol == False:
        continue

    sum += i.v

print(sum)

