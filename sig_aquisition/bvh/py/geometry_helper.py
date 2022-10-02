import numpy as np
import math

def translate(pos, translate_vec):
    return np.add(pos, translate_vec)

# def translate_vector(x,y,z):
#     return np.array([x,y,z])

def rotate_matrix_x(theta):
    return np.matrix([[1, 0, 0],
                     [0, math.cos(theta), -math.sin(theta)],
                     [0, math.sin(theta), math.cos(theta)]])

def rotate_matrix_y(phi):
    return np.matrix([[math.cos(phi), 0, math.sin(phi)],
                     [0, 1, 0],
                     [-math.sin(phi), 0, math.cos(phi)]])

def rotate_matrix_z(rho):
    return np.matrix([[math.cos(rho), -math.sin(rho), 0],
                      [math.sin(rho), math.cos(rho), 0],
                      [0, 0, 1]])

'''rotation matrix in R-P-Y order'''
def rotate_matrix(thetas):
    #
    # rmat = np.matrix([[1,0,0],
    #                  [0,1,0],
    #                   [0,0,1]])
    # for i in range(len(order)):
    #     o = order[i]
    #     if o == 'x':
    #         rmat = rotate_matrix_x(thetas[i])*rmat
    #     elif o == 'y':
    #         rmat = rotate_matrix_y(thetas[i])*rmat
    #     elif o == 'z':
    #         rmat = rotate_matrix_z(thetas[i])*rmat
    #     else:
    #         rmat = np.matrix([[1, 0, 0],
    #                           [0, 1, 0],
    #                           [0, 0, 1]])
    #         return rmat

    # raw
    cosR = math.cos(thetas[0])
    sinR = math.sin(thetas[0])

    # pitch
    cosP = math.cos(thetas[1])
    sinP = math.sin(thetas[1])

    # yaw
    cosY = math.cos(thetas[2])
    sinY = math.sin(thetas[2])

    rmat = np.mat([[cosR*cosY-sinR*sinP*sinY, -sinR*cosP, cosR*sinY+sinR*sinP*cosY],
            [sinR*cosY+cosR*sinP*sinY, cosR*cosP, sinR*sinY-cosR*sinP*cosY],
            [-cosP*sinY, sinP, cosP*cosY]])

    # rmat = np.mat([[math.cos(thetas[0])*math.cos([2])-math.sin(thetas[0])*math.sin(thetas[1])))]])

    return rmat
