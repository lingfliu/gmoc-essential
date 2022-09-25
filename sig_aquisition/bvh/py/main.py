from bvh_aquisition import bvh_import

def main():
    path = './sample'
    filename = 'run_1Char00.bvh'
    data = bvh_import(path, filename)
    print(data)


if __name__ == '__main__':
    main()