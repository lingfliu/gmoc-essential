import numpy as np

'''convert skeleton into adjascent matrix
args:
    ske: skeleton hierarchy defiened in tree structure
output:
    adjmtx: sparse representation of skeleton adjacent matrix

ske is modeled by a tree structure with each expressed as:
{   
    'name':name,
    'category': root/joint/end
    'idx':index,
    'parent_idx': index of parent,
    'offset': [dx, dy, dz], # S.B. the offset does not represent the posture during motion
    'children':[ske],
}
'''

def ske2adjmtx(ske):
    adjmtx = []
    for c in ske['children']:
        adjmtx.append([ske['idx'], c['idx'], c['offset']])
        if not c['catetory'] is 'end':
            adjmtx = ske2adjmtx(c, adjmtx)

    return adjmtx;

def adjmtx2ske(adjmtx):
    ske = {}
    ske_child = {}
    ske_parent = {}

    cnt = 0
    for v in adjmtx:
        parent_idx = v[0]
        idx = v[1]
        offset = v[2]

        if cnt == 0:
            ske['idx']  = parent_idx
            ske['children'] = []
            ske['children'].append({
                'idx':idx,
                'offset' : offset
            })
            ske_child = ske['children'][0]
            ske_parent = ske
        else:
            if not ske_parent['idx'] == parent_idx:
                ske_parent = ske_parent['x']
                ske_parent['children'] = []
                ske_parent['children'].append({
                    'idx': idx,
                    'offset': offset,
                    'parent_idx': parent_idx
                })
                ske_child = ske_parent['children'][0]


