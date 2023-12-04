class card:
    def __init__(self):
        self.winning_numbers = []
        self.my_numbers = []
        self.point_values = [0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536]
        self.copies = 1

    def add_winning_number(self, number_list):
        parts = number_list.split(' ')
        for i in parts:
            if i == '':
                continue
            self.winning_numbers.append(int(i))
    
    def add_my_number(self, number_list):
        parts = number_list.split(' ')
        for i in parts:
            if i == '':
                continue
            self.my_numbers.append(int(i))
    
    def get_winning_numbers(self):
        return self.winning_numbers
    
    def get_my_numbers(self):
        return self.my_numbers
        
    def get_copies(self):
        return self.copies
    
    def add_copies(self, number):
        self.copies += number

    def get_matches(self):
        # how many numbers match in both lists
        matches = 0
        for i in self.my_numbers:
            if i in self.winning_numbers:
                matches += 1
        return matches
    
    def get_points(self):
        return self.point_values[self.get_matches()] * self.copies


