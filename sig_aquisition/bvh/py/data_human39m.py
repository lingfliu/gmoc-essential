import os
import pickle

'''load Human 3.6M dataset by the original code gendata    
args:
    root_path: root path of the dataset
    selects:  select indice on the loading, if set [], load all data
    pre_filtered: if True, will filter data out the predefined range, see ...
return: (data, selectedIndice)
    data: data stored in 2D array with skeleton defined in the data
'''
def load_human36m_data(root_path, selects=[], pre_filtered=True):
    if not os.path.exists(root_path):
        return ([], [])

    data = []
    selectedIndice = []

'''load Human 3.6M data meta: name, skeleton hierarchy, sampling rate etc.
args: 
    root_path: root path of the dataset
    selects:  select indice on the loading, if set [], load all data meta
return: [meta] meta arrays
    meta: {
        'hierarchy': [], this is only valid if the hierarchy is uniform throughout the dataset
        'sps': number,
        ...
    }
'''
def load_human36m_meta(root_path, selects=[]):
    if not os.path.exists(root_path):
        return []

    return []


'''load Human 3.6M labels:
args: 
    root_path: root path of the dataset
    selects:  select indice on the loading, this should be set as the returns of the load_human36m_data
return: [label] label arrays
'''
def load_human36m_label(root_path, selects=[]):
    label_file_pkl = 'labels.pkl'
    if not os.path.exists(root_path):
        return []

    if os.path.exists(os.path.join(root_path, label_file_pkl)):
        with open(os.path.join(root_path, label_file_pkl)) as f:
            labels = pickle.load(f)
            f.close()
            return labels
    #TODO: load label and save the file as pickle
    return []

'''load Human 3.6M joint hierarchy:
args: 
    root_path: root path of the dataset
    index:  index of the file
    meta: meta data read from 
return: [label] label arrays
'''
def load_human36m_hierarchy(root_path, index, meta, is_uniform=True):
    if is_uniform:
        return meta['hierarchy']
    else:
        # define 
        pass