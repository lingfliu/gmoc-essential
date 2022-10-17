import numpy as np
from bvh_aquisition import bvh_import, hierarchy_flat
from skeleton_draw import draw_bvh, draw_skeleton
from geometry_helper import translate


def main():
    path = '../../sample'
    filename = 'rand_ycx_9Char00.bvh'
    # filename = 'run_1Char00.bvh'
    (hierarchy, data, sampling_rate) = bvh_import(path, filename)
    # flat = hierarchy_flat(hierarchy, [])

    # draw_skeleton(hierarchy, data[0,:])
    draw_bvh(hierarchy, data, 1/sampling_rate)

    # a = np.array([1, 0, 0])
    # offset = np.array([0,1,2])
    # print(translate(a, offset))



if __name__ == '__main__':
    main()