import os
import re
import numpy as np


def parse_node_offset(line):
    if re.search('OFFSET', line.strip()):
        return [float(v) for v in line.strip().split(' ')[1:]]
    else:
        return None

def parse_node_channel(line):
    if re.search('CHANNELS', line.strip()):
        return line.strip().split(' ')[2:]
    else:
        return None

def parse_node_attr(line):
    offset = parse_node_offset(line)
    channels = parse_node_channel(line)
    attr = {}
    if offset:
        attr['offset'] = offset
        return attr
    elif channels:
        attr['channels'] = channels
        return attr
    else:
        return None

def parse_end(f, bracelets):
    line = f.readline()
    if not re.match('^{', line.strip()):
        return None
    else:
        bracelets.append('{')

    line = f.readline()
    offset = parse_node_offset(line)

    line = f.readline()
    while line:
        if re.match('^}', line.strip()):
            bracelets.pop()
            break

    if not offset:
        return None
    else:
        return ({'offset':offset}, bracelets)

def parse_node(f, bracelets):
    hierarchy = {}
    hierarchy['children'] = []

    line = f.readline()
    while line:
        if re.match('^{', line.strip()):
            bracelets.append('{')
            break

    children = []
    line = f.readline()
    while line:
        attr = parse_node_attr(line)
        if not attr:
            if re.match('^JOINT ', line.strip()):
                (child_hierarchy, bracelets) = parse_node(f, bracelets)
                child_hierarchy['category'] = 'joint'
                child_hierarchy['name'] = line.strip().split(' ')[1]
                children.append(child_hierarchy)
                # print('parsing ' + child_hierarchy['name'])
            elif re.match('^End Site', line.strip()):
                res = parse_end(f, bracelets)
                if res:
                    (child_hierarchy, bracelets) = res
                    child_hierarchy['category'] = 'end'
                    children.append(child_hierarchy)
            elif re.match('}', line.strip()):
                bracelets.pop()
                break

        else:
            for k in attr.keys():
                hierarchy[k] = attr[k]

        line = f.readline()


    hierarchy['children'] = children

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
        while line:
            if re.match('^{', line.strip()):
                bracelets.append('{')
                break

        line = f.readline()
        while line:
            attr = parse_node_attr(line)
            if attr:
                for k in attr.keys():
                    hierarchy[k] = attr[k]
            else:
                # recursive reading
                if re.match('^JOINT', line.strip()):
                    (child_hierarchy, bracelets) = parse_node(f, bracelets)
                    child_hierarchy['category'] = 'joint'
                    child_hierarchy['name'] = line.strip().split(' ')[1]
                    hierarchy['children'].append(child_hierarchy)
                    # print('parsing ' + child_hierarchy['name'])
                elif re.match('^End Site', line.strip()):
                    res = parse_end(f, bracelets)
                    if res:
                        (child_hierarchy, bracelets) = res
                        child_hierarchy['category'] = 'end'
                        hierarchy['children'].append(child_hierarchy)
                elif re.match('^}', line.strip()):
                    bracelets.pop()
                    break

            line = f.readline()

        line = f.readline()
        foundMotion = False
        while line:
            if re.match('^MOTION', line.strip()):
                # entering motion reading
                foundMotion = True
                break
            line = f.readline()

        if not foundMotion:
            return ()

        line = f.readline()
        frames = -1
        while line:
            if re.match('^Frames:', line.strip()):
                frames = int(line.strip().split(':')[1].strip())
                break
            line = f.readline()

        line = f.readline()
        frameTime = -1
        while line:
            if re.match('^Frame Time', line.strip()):
                frameTime = float(line.strip().split(':')[1].strip())
                break

            line = f.readline()
        # there should be no white space when reading the data

        cnt = 0
        line = f.readline()
        data = []
        while line:
            if (len(line) > 0):
                vals = [float(v) for v in line.strip().split(' ')]
                data.append(vals)
                cnt += 1
            line = f.readline()

        data = np.array(data)






    if len(bracelets) == 0 and data.shape[0] == frames:
        return (hierarchy, np.array(data), frameTime)
    else:
        return ()