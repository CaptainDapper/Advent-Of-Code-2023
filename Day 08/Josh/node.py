class Node:
    def __init__(self, value):
        self.value = value

        parts = value.split('=')

        self.name = parts[0].strip()

        names = parts[1].strip().replace("(", "").replace(")", "").split(",")
        self.leftName = names[0].strip()
        self.rightName = names[1].strip()

        self.left = None
        self.right = None

        def getLeftName(self):
            return self.leftName
        
        def getRightName(self):
            return self.rightName

        def setLeftNode(self, node):
            self.left = node
        
        def setRightNode(self, node):
            self.right = node

        def getLeftNode(self):
            return self.left
        
        def getRightNode(self):
            return self.right
        
        def getNode(self, direction):
            if direction == "L":
                return self.left
            elif direction == "R":
                return self.right
            else:
                return None
            
        def isFinalNode(self):
            return self.name == "ZZZ"