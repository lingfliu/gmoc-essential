import os
import re


def parse_node(f, bracelets):
    hierarchy = {}
    hierarchy['children'] = []

    line = f.readline()
    if not re.search('{', line.strip()):
        return {}
    bracelets.append('{')

    line = f.readline()
    if not re.search('OFFSET', line.strip()):
        return {}
    hierarchy['offset'] = line.strip().split(' ')[1:]

    line = f.readline()
    if not re.search('CHANNELS', line):
        return {}
    hierarchy['channels'] = line.strip().split(' ')[2:]

    line = f.readline()
    while not re.search('}', line) and line:
        if re.search('JOINT', line):
            (child_hierarchy, bracelets) = parse_node(f, bracelets)
            child_hierarchy['category'] = 'joint'
            child_hierarchy['name'] = line.strip().split(' ')[1]
            hierarchy['children'].append(child_hierarchy)
        elif re.search('End Site', line.strip()):
            end_hierarchy = {}
            end_hierarchy['category'] = 'end'
            line = f.readline()
            line = f.readline()
            end_hierarchy['offset'] = line.strip().split(' ')[1:]
            line = f.readline()
            hierarchy['children'].append(end_hierarchy)
        line = f.readline()

    return (hierarchy, bracelets)

def bvh_import(path, name):
    hierarchy = {}
    bracelets = []


    with open(os.path.join(path, name)) as f:
        # locate hierarchy
        foundHierarchy = False
        line = f.readline()
        while line:
            if re.match('^HIERARCHY', line.strip()):
                foundHierarchy = True
                break
            line = f.readline()
        if not foundHierarchy:
            return {}

        line = f.readline()
        foundRoot = False
        while line:
            if re.match('^ROOT ', line.strip()):
                foundRoot = True
                break
        if not foundRoot:
            return {}

        # parse root
        hierarchy['category'] = 'root'
        hierarchy['name'] = line.strip().split(' ')[1]
        hierarchy['children']  = []

        line = f.readline()
        if not re.search('{', line.strip()):
            return {}
        line = f.readline()
        if not re.search('OFFSET', line):
            return {}
        hierarchy['offset'] = line.strip().split(' ')[1:]

        line = f.readline()
        if not re.search('CHANNELS', line):
            return {}
        hierarchy['channels'] = line.strip().split(' ')[2:]

        line = f.readline()
        while line:
            # recursive reading
            if re.search('JOINT', line):
                (child_hierarchy, bracelets) = parse_node(f, bracelets)
                child_hierarchy['category'] = 'joint'
                child_hierarchy['name'] = line.strip().split(' ')[1]
                hierarchy['children'].append(child_hierarchy)

    return hierarchy
