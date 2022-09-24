import os

def bvh_import(path, name):
    with open(os.path.join(path, name)) as f:
        line = f.read()
        while line:
            print(line)

    return line

