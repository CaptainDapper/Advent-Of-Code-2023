def ReadFile(filename):
    with open(filename) as f:
        content = f.readlines()
    content = [x.strip() for x in content]
    return content

def GetNumberArray(strList):
    list = strList.split(" ")
    numberArray = []
    for i in list:
        if i == "":
            continue
        numberArray.append(int(i))
    return numberArray