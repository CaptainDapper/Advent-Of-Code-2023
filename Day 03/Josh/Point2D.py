from Rectangle import Rectangle

class Point2D:
    def __init__(self, x=0, y=0, c = '', v = -1):
        self.x = x
        self.y = y
        self.c = c
        self.v = v
    
    def __str__(self):
        # sx = x pad left with spaces
        sx = str(self.x).rjust(3)        
        # sy = y pad left with 0's
        sy = str(self.y).rjust(3)

        if self.v == -1:
            return f'({sx}, {sy}) is {self.c}'
        else:
            return f'({sx}, {sy}) is {self.c} with value {self.v}'
    
    def get_rectagle(self):
        return Rectangle(self.x, self.y, len(self.c), 0)
        