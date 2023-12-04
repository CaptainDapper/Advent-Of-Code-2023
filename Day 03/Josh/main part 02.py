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
# remove any points that don't have a value of *
symbols = list(filter(lambda x: x.c == '*', symbols))
# symbols.append(Point2D(0,0))

# for i in symbols:
#      print(i)

values = get_points_from_string_array_with_values(content)

# for i in values:
#       print(i)  

for v in values:
    bbox = v.get_rectagle().expand(1, 1, 1, 1)
    for s in symbols:
        if is_point_in_rectangle(s, bbox):
            v.add_near_point(s)
            s.add_near_point(v)



for yPos in range(len(content)):
    i = content[yPos]
    i = i.replace('\n', '')
    # Filter symbols for y position
    symbolsY = list(filter(lambda x: x.y == yPos, symbols)) 
    valuesY = list(filter(lambda x: x.y == yPos, values))

    # print ("Symbols:")
    # for v in symbolsY:
    #     print (v)

    # print ("Values:")
    # for v in valuesY:
    #     print (v)

    # print ("Line:")        
    # print (i)
    
    for xPos in range(len(i)):

        j = i[xPos]
        # Filter symbols for x position
        # symbolsX = list(filter(lambda x: x.x == xPos, symbolsY))
        symbolsX = list(filter(lambda x: x.point_in_rect(Point2D(xPos, yPos)), symbolsY))
        valuesX = list(filter(lambda x: x.point_in_rect(Point2D(xPos, yPos)), valuesY))


        if len(symbolsX) != 0:
            print('\033[33m', end='')  # change color of print to yellow            
        elif len(valuesX) > 1:
            print('\033[31m', end='')  # change color of print to red
        elif len(valuesX) == 1:
            if len(valuesX[0].get_near_points()) >= 1:                
                print('\033[34m', end='')  # change color of print to red
            else:
                print('\033[32m', end='')  # change color of print to red
        else:
            print('\033[37m', end='')  # change color of print to white

        # print(f'{xPos} {j}')
        print(j, end='')
    print()


sum = 0
gears = list(filter(lambda x: x.c == '*' and len(x.get_near_points()) == 2, symbols))
for i in gears:
    g1 = i.get_near_points()[0].get_value()
    g2 = i.get_near_points()[1].get_value()
    gr = g1 * g2
    sum += gr

print(sum)



