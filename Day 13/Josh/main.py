from helpers import ReadFile, my_rotate, GetNumberArray

# Open the file in read mode
content = ReadFile('day 13\\josh\\test.txt')
# content = ReadFile('day 13\\josh\\input.txt')

# content90 = RotateArray(content, 1)
content90 = my_rotate(content)

print (len(content))
print (len(content90))

for line in content90:
    print(line)

# for line in content90:
#     print(line)