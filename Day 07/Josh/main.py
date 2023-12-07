from helpers import ReadFile
from hand import Hand

# Open the file in read mode
content = ReadFile('day 07\\josh\\test.txt')
#content = ReadFile('day 07\\josh\\input.txt')

hands = []
for line in content:
    hands.append(Hand(line))

hands.append(Hand('AAAAA 1'))

for hand in hands:
    counts = Counter(hand.get_cards())
    print(counts)
