# Open the file in read mode
file = open('day 02\\josh\\input.txt', 'r')

# Read the entire content of the file
content = file.readlines()

# Close the file
file.close()

maxRed = 12
maxGreen = 13
maxBlue = 14

sum = 0
for i in content:
    i = i.replace("\n", "")  # remove new line
    i = i.split(":")         # Split on Colon  Game X: Values
    game = int(i[0].replace("Game ", ""))
    results = i[1].split(";") # Split on Semicolon  Values: Values    
    possible = True
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
        if red > maxRed or green > maxGreen or blue > maxBlue:
            possible = False
            break
    if possible:
        sum += game

print(sum)


            
    