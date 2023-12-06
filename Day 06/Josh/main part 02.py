from helpers import ReadFile



def get_wins(time, min_distance):
    wins = []
    
    for i in range(time):
        power = i
        timeLeft = time - i
        distance = power * timeLeft
        if distance > min_distance:
            wins.append((power, timeLeft, distance))
    return wins

# Time:        44     80     65     72
# Distance:   208   1581   1050   1102

# Time:        44806572
# Distance:   208158110501102

race01 = get_wins(44806572, 208158110501102)

print(len(race01))
