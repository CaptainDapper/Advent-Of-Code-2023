from pygame import image, sprite

class TileImage():
    def __init__(self, filename, value):
        self.sprite = sprite.Sprite()
        self.sprite.image = image.load(filename)
        self.sprite.rect = self.sprite.image.get_rect()
        self.value = value
        self.filename = filename
        pass