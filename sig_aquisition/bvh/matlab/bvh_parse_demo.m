clear;clc;

% file_path = 'sample/run_1Char00.bvh'
% file_path = 'sample/walk-cycle.bvh'
file_path = 'sample/rand_ycx_9Char00.bvh'

[hierarchy, data, frameTime] = parse_bvh(file_path);
[adjmtx, adjmtx_info, joint_names] = hierarchy2adjmtx(hierarchy);

% fig_id = 112;
% draw_skeleton(fig_id, hierarchy);

fig_id = 123;
draw_bvh(fig_id, hierarchy,data, frameTime);

