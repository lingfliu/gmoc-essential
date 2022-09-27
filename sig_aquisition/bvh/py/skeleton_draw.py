import matplotlib.pyplot as plt
import numpy as np
from geometry_helper import rotate_matrix
import math

def draw_skeleton_child(axes, p_parent, hierarchy):
    print('drawing', hierarchy['name'])
    p_current = p_parent + np.array(hierarchy['offset'])
    axes.plot([p_parent[0], p_current[0]], [p_parent[1], p_current[1]], [p_parent[2], p_current[2]])
    for c in hierarchy['children']:
        if c['category'] == 'end':
            p_end = p_current + np.array(c['offset'])
            axes.plot([p_current[0], p_end[0]], [p_current[1], p_end[1]], [p_current[2], p_end[2]])
        else:
            draw_skeleton_child(axes, p_current, c)



def draw_skeleton(hierarchy, data):
    # draw in 3D from Hips
    axes = plt.figure().add_subplot(projection='3d')
    axes.view_init(elev=100, azim=-90)
    axes.axis('auto')

    p_root = np.array(hierarchy['offset'])

    for c in hierarchy['children']:
        draw_skeleton_child(axes, p_root, c)

    plt.show()


def draw_motion(axes, p_parent, r_mat_parent, hierarchy, data):
    p_current = p_parent + np.transpose(np.mat(hierarchy['offset']))
    motion = data[:6]
    r_mat = rotate_matrix(np.array(motion[3:]) / 180 * math.pi, ['z', 'x', 'y'])
    p_current = r_mat*p_current
    axes.plot([p_parent[0,0], p_current[0,0]], [p_parent[1,0], p_current[1,0]], [p_parent[2,0], p_current[2,0]])
    cnt = 0
    for c in hierarchy['children']:
        data = data[6:]
        if c['category'] == 'end':
            p_end = p_current + np.transpose(np.mat(c['offset']))
            motion = data[:6]
            r_mat = rotate_matrix(np.array(motion[3:]) / 180 * math.pi, ['z', 'x', 'y'])
            p_end = r_mat * p_end
            axes.plot([p_current[0, 0], p_end[0, 0]], [p_current[1, 0], p_end[1, 0]], [p_current[2, 0], p_end[2, 0]])
        else:
            draw_motion(axes, p_current, r_mat_parent, c, data)

        cnt += 1



def draw_bvh(hierarchy, data, fps):


    # draw in 3D from Hips
    axes = plt.figure().add_subplot(projection='3d')

    for idx in range(data.shape[0]):
        axes = plt.figure().add_subplot(projection='3d')
        # plt.ion()
        # plt.cla()

        p_root = np.array(hierarchy['offset'])
        motion = data[idx, :6]
        r_mat = rotate_matrix(np.array(motion[3:])/180*math.pi, ['z', 'x', 'y'])
        p_root = r_mat*np.transpose(np.matrix(p_root))

        for c in hierarchy['children']:
            draw_motion(axes, p_root, r_mat, c, data[idx][6:])

        plt.show()
        # plt.pause(1/fps)
        plt.pause(1)
        plt.ioff()
        # break

        if idx > 1:
            break

