import os
import re


def parse_joint(f):
    return ''

def bvh_import(path, name):
    hierarchy = {
            'category':'ROOT',
            'name':'hips',
            'offset': [0,0,0],
            'channels': ['xpos', 'ypos', 'zpos', 'xrot', 'yrot', 'zrot'],
            'children': [
                {'name':'RightUpLeg',}
            ]
    }

    with open(os.path.join(path, name)) as f:
        line = f.readline()
        if not re.match('^HIERARCHY', line):
            return {}

        # parse hierachy header
        line = f.readline()
        if not re.match('^ROOT ', line):
            return {}

        root_name = line.split(' ')[1].strip()
        hierarchy['name'] = root_name
        hierarchy['category'] = 'root'

        line = f.readline()
        if not re.search('{', line):
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
        if re.search('JOINT'):
            sub_hierachy = parse_joint(f, line.split(' ')[1])
            hierarchy['children'].append(sub_hierachy)

            # while line:
            #     # parse hierachy
            #     # parse header
            #     line.freadline
            # else
            # line = f.readline()


    return hierarchy
