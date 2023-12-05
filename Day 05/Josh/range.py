class Range:
    def __init__(self, source_start, dest_start, length):
        self.source_start = source_start
        self.dest_start = dest_start
        self.length = length 

    def __str__(self):
        return f'{self.source_start} -> {self.dest_start} length {self.length}'
    
    def in_source_range(self, source_value):
        return source_value >= self.source_start and source_value < self.source_start + self.length
    
    def get_dest_value(self, source_value):
        if not self.in_source_range(source_value):
            return source_value
        return self.dest_start + source_value - self.source_start