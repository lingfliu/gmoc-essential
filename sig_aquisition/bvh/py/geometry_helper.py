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

def rotate_matrix(thetas, order):
    rmat = np.matrix([[1,0,0],
                     [0,1,0],
                      [0,0,1]])
    for i in range(len(order)):
        o = order[i]
        if o == 'x':
            rmat = rmat*rotate_matrix_x(thetas[i])
        elif o == 'y':
            rmat = rmat*rotate_matrix_y(thetas[i])
        elif o == 'z':
            rmat = rmat*rotate_matrix_z(thetas[i])
        else:
            rmat = np.matrix([[1, 0, 0],
                              [0, 1, 0],
                              [0, 0, 1]])
            return rmat

    return rmat
