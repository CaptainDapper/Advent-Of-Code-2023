
# Open the file in read mode
file = open('day 01\\input.txt', 'r')
#file = open('day 01\\testdata.txt', 'r')

# Read the entire content of the file
content = file.readlines()

# Close the file
file.close()

# Create an string array
number_names = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

sum = 0
# print content
for i in content:
    # Remove the new line character
    i = i.replace("\n", "")
    # Replace the number names with numbers
    # print (i)
    # find the starting index of the word one in I
    
    lowest_idx = -1
    number_found = ""
    while lowest_idx != 999999:
        lowest_idx = 999999
        number_found = ""
        for j in range(0, len(number_names)):
            idx = i.find(number_names[j])
            if (idx  == -1):
                continue
            if (idx < lowest_idx):            
                lowest_idx = idx
                number_found = number_names[j]    
        if (lowest_idx == 999999):
            break
        i = i.replace(number_found, str(number_names.index(number_found) + 1), 1)

    s = ''.join(c for c in i if c.isdigit())   

    first_character = s[0]  # Get the first character
    last_character = s[-1]  # Get the last character
    number = int(first_character + last_character)  # Convert to number    
    
    sum += number

print(sum)



