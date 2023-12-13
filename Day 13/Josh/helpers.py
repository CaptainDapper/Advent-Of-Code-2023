def ReadFile(filename):
    with open(filename) as f:
        content = f.readlines()
    content = [x.strip() for x in content]
    return content

def my_rotate(content):
    line1 = content[0]
    newContent = list()
    for i in range(len(line1)):
        newLine = ""
        for j in range(len(content)):
            if i >= len(content[j]):
                continue
            newLine += content[j][i]
        print (newLine)
        newContent.append(newLine)
    return newContent

def rotate_matrix_90(matrix):
    return [list(reversed(i)) for i in zip(*matrix)]

def RotateArray(array, n):
    return array[n:] + array[:n]

def GetNumberArray(strList):
    list = strList.split(" ")
    numberArray = []
    for i in list:
        if i == "":
            continue
        numberArray.append(int(i))
    return numberArray