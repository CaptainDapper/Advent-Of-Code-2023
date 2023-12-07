from collections import Counter

class Hand:
    def __init__(self, str):        
        parts = str.strip().split(' ')
        self.cards = parts[0]
        self.bid = int(parts[1])

    def get_cards(self):
        return self.cards
    
    def get_bid(self):
        return self.bid
    
    def __str__(self):
        return self.cards + ' ' + str(self.bid) + ' ' + str(self.get_strength())
    
    def get_strength(self):
        counts = Counter(self.get_cards())
        # High Cad       - 1
        # 1 Pair         - 2
        # 2 Pair         - 3
        # 3 of a kind    - 4
        # Full House     - 5
        # 4 of a kind    - 6
        # 5 of a kind    - 7
        return 0
    
    def get_card_value(str):
        case = {
            'A': 14,
            'K': 13,
            'Q': 12,
            'J': 11,
            'T': 10,
            '9': 9,
            '8': 8,
            '7': 7,
            '6': 6,
            '5': 5,
            '4': 4,
            '3': 3,
            '2': 2            
        }
        return case[str[0]]
        