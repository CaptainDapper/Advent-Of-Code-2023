from Point2D import Point2D
from Rectangle import Rectangle

# create a function that takes in a string and returns a list of points
def get_points_from_string_array(string_array):
    points = []
    yPos = 0
    for yPos in range(len(string_array)):
        i = string_array[yPos]
        i = i.replace('\n', '')
        for xPos in range(len(i)):
            j = i[xPos]
            if is_digit(j) or is_alpha(j) or is_period(j):
                continue
            points.append(Point2D(xPos, yPos, j))
    return points

def is_digit(j):
    if (j == '-'):
        return False
    if (j == '+'):
        return False
    return j.isdigit()
    
def is_alpha(j):
    return j.isalpha()

def is_period(j):
    return j == '.'

def get_points_from_string_array_with_values(string_array):
    points = []
    sx = 0
    sy = 0
    numStr = ''
    inNumber = False
    for yPos in range(len(string_array)):
        i = string_array[yPos]
        i = i.replace('\n', '')
        for xPos in range(len(i)):
            if inNumber == False and not is_digit(i[xPos]):   # if we are not in a number and the current character is not a digit
                continue
            elif inNumber == False and is_digit(i[xPos]):     # if we are not in a number and the current character is a digit
                inNumber = True
                sx = xPos
                sy = yPos
                numStr = i[xPos]
                continue
            elif inNumber == True and is_digit(i[xPos]):      # if we are in a number and the current character is a digit
                numStr += i[xPos]
                continue
            elif inNumber == True and not is_digit(i[xPos]):  # if we are in a number and the current character is not a digit
                inNumber = False
                points.append(Point2D(sx, sy, numStr, int(numStr)))
                continue    
        if inNumber == True:
            inNumber = False
            points.append(Point2D(sx, sy, numStr, int(numStr)))       
    return points

def is_point_in_rectangle(point, rectangle):
    return (point.x >= rectangle.x and point.x < rectangle.x + rectangle.width and point.y >= rectangle.y and point.y <= rectangle.y + rectangle.height)
