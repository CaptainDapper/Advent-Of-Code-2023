from collections import Counter
from HandEnums import *

class Hand:
    def __init__(self, str, wildCard = ''):        
        parts = str.strip().split(' ')
        sHand = parts[0]
        sBid = parts[1]
        self.cards = self.calculate_best_hand(sHand, wildCard)
        self.bid = int(sBid)
        self.hand_data = Counter(self.get_cards())

    def calculate_best_hand(self, cards, wildCard = ''):
        if wildCard == '':                          # no wild card, return the hand as is
            return cards
        if wildCard not in cards:                   # J Jokers are whild cards, and no wild cards are found in this hand
            return cards
        
        highestValue = 0
        JokerValues = ['A', 'K', 'Q', 'T', '9', '8', '7', '6', '5', '4', '3', '2']
        BestJokerValue = ''
        for J in JokerValues:
            handStr = cards.replace('J', J)
            newHand = Hand(handStr + " 0")
            handValue = newHand.get_hand_value()
            if handValue > highestValue:
                highestValue = handValue
                BestJokerValue = J
        return cards.replace('J', BestJokerValue)

    def get_cards(self):
        return self.cards
    
    def get_bid(self):
        return self.bid
    
    def __str__(self):
        return self.cards + ' ' + str(self.bid) + ' ' + str(self.get_strength())
    
    def get_hand_type(self):
        return GetHandType(self.hand_data)
    
    def get_x_card(self, x):
        return GetCardValue(self.cards[x])
    
    def get_hand_value(self):
        value = 0

        value += self.get_hand_type().value * 10000000000
        value += self.get_x_card(0).value * 100000000
        value += self.get_x_card(1).value * 1000000
        value += self.get_x_card(2).value * 10000
        value += self.get_x_card(3).value * 100
        value += self.get_x_card(4).value
        return value
    

