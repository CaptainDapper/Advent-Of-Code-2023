# Open the file in read mode
file = open('day 02\\josh\\input.txt', 'r')

# Read the entire content of the file
content = file.readlines()

# Close the file
file.close()

maxRed = 12
maxGreen = 13
maxBlue = 14

# Not done yet.  Have to go to bed.
sum = 0
for i in content:
    minRed = 0
    minGreen = 0
    minBlue = 0
    i = i.replace("\n", "")  # remove new line
    i = i.split(":")         # Split on Colon  Game X: Values
    game = int(i[0].replace("Game ", ""))
    results = i[1].split(";") # Split on Semicolon  Values: Values    
    
    # what is the largest int value

    for j in results:
        red = 0
        green = 0
        blue = 0
        data = j.split(",")       # Each Turn of the game (Red, Green, Blue values))
        for k in data:
            # if k contains red
            if "red" in k:
                red = int(k.replace("red", ""))
            elif "green" in k:
                green = int(k.replace("green", ""))
            elif "blue" in k:
                blue = int(k.replace("blue", ""))
        if red > minRed:
            minRed = red
        if green > minGreen:
            minGreen = green
        if blue > minBlue:
            minBlue = blue

    power = minRed * minGreen * minBlue
    sum += power

print(sum)


            
    