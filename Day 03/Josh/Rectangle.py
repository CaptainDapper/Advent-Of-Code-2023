class Rectangle:

    def __init__(self, x, y, width, height):
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        if (self.width < 0):
            self.width = 0
        if (self.height < 0):
            self.height = 0
        if (self.x < 0):
            self.x = 0
        if (self.y < 0):
            self.y = 0

    def get_x(self):
        return self.x
    
    def get_y(self):
        return self.y
    
    def get_width(self):
        return self.width
    
    def get_height(self):
        return self.height

    def __str__(self):
        return f'({self.x}, {self.y}, {self.x + self.width}, {self.y + self.height}) width is {self.width} and height is {self.height}'
        
    def clone(self):
        return Rectangle(self.x, self.y, self.width, self.height)

    # returns an expanded rectangle (new rectangle) (does not modify the current rectangle)
    def expand(self, top, right, bottom, left):
        ret = self.clone()
        ret.x -= left
        ret.y -= top
        ret.width += right + left
        ret.height += bottom + top
        if (ret.width < 0):
            ret.width = 0
        if (ret.height < 0):
            ret.height = 0
        if (ret.x < 0):
            ret.x = 0
        if (ret.y < 0):
            ret.y = 0
        return ret
        
    # return true if the point is inside the rectangle
    # def contains_point(self, point):
    #     return (point.x >= self.x and point.x <= self.x + self.width and point.y >= self.y and point.y <= self.y + self.height)