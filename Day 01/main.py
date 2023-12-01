
# Open the file in read mode
file = open('input.txt', 'r')

# Read the entire content of the file
content = file.readlines()

# Close the file
file.close()

sum = 0
# print content
for i in content:
    s = ''.join(c for c in i if c.isdigit())   
    first_character = s[0]  # Get the first character
    last_character = s[-1]  # Get the last character
    number = int(first_character + last_character)  # Convert to number    
    sum += number

print(sum)


