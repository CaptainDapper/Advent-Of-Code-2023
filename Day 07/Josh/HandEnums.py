from enum import Enum

class HandTypeEnum(Enum):
    HIGHCARD = 0
    ONEPAIR = 1
    TWOPAIR = 2
    THREEOFAKIND = 3
    FULLHOUSE = 4
    FOUROFAKIND = 5
    FIVEOFAKIND = 6

def GetHandType(counts):
    if len(counts) == 1:                                # AAAAA { `A` : 5 } 
        return HandTypeEnum.FIVEOFAKIND
    elif len(counts) == 2:       
        if 4 in counts.values():                        # AAAAK { `A` : 4, `K` : 1 }
            return HandTypeEnum.FOUROFAKIND
        else:
            return HandTypeEnum.FULLHOUSE               # AAAKK { `A` : 3, `K` : 2 }
    elif len(counts) == 3:
        if 3 in counts.values():                        # AAAKQ { `A` : 3, `K` : 1, `Q` : 1 }
            return HandTypeEnum.THREEOFAKIND
        else:
            return HandTypeEnum.TWOPAIR                 # AAKKQ { `A` : 2, `K` : 2, `Q` : 1 }
    elif len(counts) == 4:
        return HandTypeEnum.ONEPAIR                     # AAKQJ { `A` : 2, `K` : 1, `Q` : 1, `J` : 1 }
    elif len(counts) == 5:
        return HandTypeEnum.HIGHCARD                    # AKQJT { `A` : 1, `K` : 1, `Q` : 1, `J` : 1, `T` : 1 }
    return HandTypeEnum.HIGHCARD                        # AKQJT { `A` : 1, `K` : 1, `Q` : 1, `J` : 1, `T` : 1 }

class CardValueEnum(Enum):
    ACE = 14
    KING = 13
    QUEEN = 12
    JACK = 11
    TEN = 10
    NINE = 9
    EIGHT = 8
    SEVEN = 7
    SIX = 6
    FIVE = 5
    FOUR = 4
    THREE = 3
    TWO = 2
    WILDCARD = 1
    UNKNOWN = 0

def GetCardValue(str, wildCard = ''):

    if (str == wildCard):
        return CardValueEnum.WILDCARD
    
    switcher = {
        'A': CardValueEnum.ACE,
        'K': CardValueEnum.KING,
        'Q': CardValueEnum.QUEEN,
        'J': CardValueEnum.JACK,
        'T': CardValueEnum.TEN,
        '9': CardValueEnum.NINE,
        '8': CardValueEnum.EIGHT,
        '7': CardValueEnum.SEVEN,
        '6': CardValueEnum.SIX,
        '5': CardValueEnum.FIVE,
        '4': CardValueEnum.FOUR,
        '3': CardValueEnum.THREE,
        '2': CardValueEnum.TWO            
    }
    return switcher.get(str, CardValueEnum.UNKNOWN)