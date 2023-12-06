class Range:
    def __init__(self, source_start: int, dest_start: int, length):
        self.source_start = source_start
        self.dest_start = dest_start
        self.length = length 
        self.cache = { }
        for i in range(length):
            self.cache[source_start + i] = dest_start + i

    def __str__(self):
        return f'{self.source_start} -> {self.dest_start} length {self.length}'
       
    def get_dest_value(self, source_value):
        if source_value in self.cache:
            return self.cache[source_value]
        return None
        
    # create an IEnumerable of the source values
    def get_source_values(self):
        for i in range(self.source_start, self.source_start + self.length):
            yield i