from helpers import ReadFile
from hand import Hand

# Open the file in read mode
content = ReadFile('day 07\\josh\\test.txt')
# content = ReadFile('day 07\\josh\\input.txt')

hands = []
for line in content:
    hands.append(Hand(line, 'J'))

# sort by hand value
hands.sort(key=lambda x: x.get_hand_value(), reverse=False)

Rank = 1
TotalWinnings = 0
for hand in hands:
    print(f"{hand.get_hand_value()}: [{Rank}] * [{hand.get_bid()}] = [{hand.get_bid() * Rank}] {hand.get_cards()} -> {hand.get_hand_type()}")
    TotalWinnings += hand.get_bid() * Rank
    Rank += 1

print(f"Total Winnings: {TotalWinnings}")
