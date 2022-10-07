# import re
#
# # res = re.match('^ROOT ', 'ROOTHIPS')
# res = re.search(r'ROOT ', 'hello ROOT HIPS')
# if res:
#     print('matched')
# else:
#     print('unmatched')
#
# a = [1,2,3]
# b = [1,2,3]
# c = [a[i]+b[i] for i in range(len(a))]
# print(c)
import numpy as np
import matplotlib.pyplot as plt

# fig = plt.figure()
# axes = plt.figure().add_subplot(projection='3d')
# axes.view_init(elev=50, azim=-20)
# axes = plt.axes(projection='3d')
# x = np.arange(-5,10,0.1)
# y = np.arange(-5,10,0.1)
# X,Y = np.meshgrid(x,y)
# Z = np.sin(X) + np.cos(Y)
# Z1 = np.sin(X) + np.cos(Y) + 1
# z2 = np.sin(x)+ np.cos(y) + 2
# axes.plot_surface(X,Y,Z, cmap='rainbow')
# axes.plot_surface(X,Y,Z1)
# axes.plot(x,y,z2)
# plt.show()

# from geometry_helper import rotate_matrix
# import math
# a = np.mat([[0, 0, 1]])
# thetas = np.array([0, 0, 45])/180*math.pi
# r = rotate_matrix(thetas)
#
# b = r*np.transpose(a)
# print('a', a)
# print('r', r)
# print('b', b)

import matplotlib.pyplot as plt
import math

# axes = plt.figure().add_subplot(projection='3d')
# axes = plt.figure().add_subplot(1,1,1)
# for i in range(100):
#     plt.ion()
#     # plt.cla()
#     x = np.array([v/180*math.pi for v in range(i*10)])
#     y = np.array([v/180*math.pi for v in range(i*10)])
#     z = np.array([math.cos(x[d]) + math.sin(y[d]) for d in range(len(x))])
#
#     axes.plot(x,y)
#     plt.show()
#     plt.pause(0.1)

from bvh import Bvh

with open('sample/run_1Char00.bvh') as f:
    mocap = Bvh(f.read())

    print([str(item) for item in mocap.root])
    # mocap.frame_joint_channels(0, )
    print(mocap.nframes)
    a = 1
