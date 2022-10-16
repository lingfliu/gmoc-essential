import numpy as np

'''IK via jacobian
args:
    pos_init: initial posture
    trace_end: moving trace of end effector
    hierarchy: skeleton hierarchy
return:
    [posture]: postures along the moving trace
'''
def jacobian(pos_init, trace_end, hierarchy):
    return [0,0,0,0]