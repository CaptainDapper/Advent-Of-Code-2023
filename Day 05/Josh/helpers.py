

def ReadFile(filename):
    with open(filename) as f:
        content = f.readlines()
    return content

def GetSeedsArray(seeds):
    parts = seeds.split(":")
    return GetNumberArray(parts[1])

def GetNumberArray(strList):
    list = strList.split(" ")
    numberArray = []
    for i in list:
        if i == "":
            continue
        numberArray.append(int(i))
    return numberArray