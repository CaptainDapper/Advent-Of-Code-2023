from tile_image import TileImage

class TileImageCollection:

    def __init__(self, basePath):
        self.basePath = basePath
        self.tileImages = { }

        self.addTileImage('tile_7.png', '7')
        self.addTileImage('tile_F.png', 'F')
        self.addTileImage('tile_horizontal_pipe.png', '-')
        self.addTileImage('tile_J.png', 'J')
        self.addTileImage('tile_L.png', 'L')
        self.addTileImage('tile_vertical_pipe.png', '|')
        self.addTileImage('tile_period.png', '.')        
        self.addTileImage('tile_s.png', 'S')        
    
    def addTileImage(self, filename, value):
        fName = self.basePath + filename
        tileImage = TileImage(fName, value)
        self.tileImages[value] = tileImage
        
    def getTileImage(self, value):
        return self.tileImages[value]
