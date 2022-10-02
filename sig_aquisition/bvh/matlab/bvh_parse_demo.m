clear;clc;

file_path = 'sample/run_1Char00.bvh'

[hierarchy, data, frameTime] = parse_bvh(file_path);

fig_id = 123;
draw_bvh(fig_id, hierarchy,data, frameTime);

