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
axes = plt.figure().add_subplot(projection='3d')
axes.view_init(elev=50, azim=-20)
# axes = plt.axes(projection='3d')
x = np.arange(-5,10,0.1)
y = np.arange(-5,10,0.1)
X,Y = np.meshgrid(x,y)
Z = np.sin(X) + np.cos(Y)
Z1 = np.sin(X) + np.cos(Y) + 1
z2 = np.sin(x)+ np.cos(y) + 2
# axes.plot_surface(X,Y,Z, cmap='rainbow')
# axes.plot_surface(X,Y,Z1)
axes.plot(x,y,z2)
plt.show()