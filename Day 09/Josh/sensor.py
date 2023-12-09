from helpers import GetNumberArray

class Sensor:
    def __init__(self, value):
        self.data = []
        self.data.append(GetNumberArray(value))
        self.PopulateData()
    
    def print(self):
        for i in self.data:
            print(i)
        


    def PopulateData(self):
        difArray = self.GetDiffArray(self.data[0])
        # while difarray does not contain all 0's
        while not self.IsAllZero(difArray):
            self.data.append(difArray)
            difArray = self.GetDiffArray(difArray)

        self.data.append(difArray)
        

    def IsAllZero(self, a):
        for i in a:
            if i != 0:
                return False
        return True        

    def GetDiffArray(self, a):
        ret = []
        lastValue = None
        for i in a:
            if lastValue == None:
                lastValue = i
                continue
            ret.append(i - lastValue)
            lastValue = i
        return ret
    
    def print_reverse(self):
        for i in range(1, len(self.data) + 1):
            d = self.data[i * -1]
            print(i, d)

    def ExtrapolateNextValues(self):
        lastCalculatedValue = None
        for i in range(1, len(self.data) + 1):
            j = i * -1
            if lastCalculatedValue == None:
                self.data[j].append(0)
                lastCalculatedValue = 0
                continue           
            lastCalculatedValue = self.data[j][-1]  + lastCalculatedValue
            self.data[j].append(lastCalculatedValue)

    def ExtrapolatePreviousValues(self):
        lastCalculatedValue = None
        for i in range(1, len(self.data) + 1):
            j = i * -1
            if lastCalculatedValue == None:
                # insert at beginning
                self.data[j].insert(0, 0)
                lastCalculatedValue = 0
                continue           
            lastCalculatedValue = self.data[j][0] - lastCalculatedValue
            self.data[j].insert(0, lastCalculatedValue)

    #     self.data[-1].append(lastCalculatedValue)
    #     # for loop through data in reverse
    #     for i in range(len(self.data)-1, 0, -1):
    #          d = self.data[i]


    #          print(i)

    