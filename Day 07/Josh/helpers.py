def ReadFile(filename):
    with open(filename) as f:
        content = f.readlines()
    return content

