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

race01 = get_wins(44, 208)
race02 = get_wins(80, 1581)
race03 = get_wins(65, 1050)
race04 = get_wins(72, 1102)

print(len(race01))
print(len(race02))
print(len(race03))
print(len(race04))

result = len(race01) * len(race02) * len(race03) * len(race04)
print(result)
