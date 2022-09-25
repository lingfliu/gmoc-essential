import re

# res = re.match('^ROOT ', 'ROOTHIPS')
res = re.search(r'ROOT ', 'hello ROOT HIPS')
if res:
    print('matched')
else:
    print('unmatched')