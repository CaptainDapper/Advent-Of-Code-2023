from tile_image import TileImage

class TileImageCollection:

    def __init__(self, basePath):
        self.basePath = basePath
        self.tileImages = { }

        self.addTileImage('tile_hash.png', '#')
        self.addTileImage('tile_period.png', '.')
    
    def addTileImage(self, filename, value):
        fName = self.basePath + filename
        tileImage = TileImage(fName, value)
        self.tileImages[value] = tileImage
        
    def getTileImage(self, value):
        return self.tileImages[value]
