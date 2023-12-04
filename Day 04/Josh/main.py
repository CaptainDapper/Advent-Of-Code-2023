from card import card

# Open the file in read mode
# file = open('day 04\\josh\\test.txt', 'r')
file = open('day 04\\josh\\input.txt', 'r')

# Read the entire content of the file
content = file.readlines()

# Close the file
file.close()

cards = []

for i in content:
    i = i.replace('\n', '')
    print(i)
    dParts = i.split(':')
#    for j in dParts:
#        print(j)
    xParts = dParts[1].split('|')
#    print(f"Winners: {xParts[0]}")
#    print(f"Mine: {xParts[1]}")

    c = card()
    c.add_winning_number(xParts[0])
    c.add_my_number(xParts[1])
    cards.append(c)

# sum all the points in the cards
total = 0
for l in range(len(cards)):
    i = cards[l]
    print(f'Card {l} has {i.get_points()} points')
    total += i.get_points()

print(total)