import numpy as np
import math

def translate(pos, translate_vec):
    return np.add(pos, translate_vec)

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

'''rotation matrix given r, p, y'''
def rotate_matrix(raw, pitch, yaw):
    # raw
    cosR = math.cos(raw)
    sinR = math.sin(raw)

    # pitch
    cosP = math.cos(pitch)
    sinP = math.sin(pitch)

    # yaw
    cosY = math.cos(yaw)
    sinY = math.sin(yaw)

    rmat = np.mat([[cosR*cosY-sinR*sinP*sinY, -sinR*cosP, cosR*sinY+sinR*sinP*cosY],
            [sinR*cosY+cosR*sinP*sinY, cosR*cosP, sinR*sinY-cosR*sinP*cosY],
            [-cosP*sinY, sinP, cosP*cosY]])

    return rmat

'''convert global position into local position & rotate
args:
    pos_x: global positions of joints
return:
    [x, y, z, raw, pitch, yaw]: local position & rotation of joint 2 with respect to local coordinate from joint 1
'''
def pos2rotate(pos_0, pos_1, pos_2):
    return [0, 0, 0, 0, 0, 0]
