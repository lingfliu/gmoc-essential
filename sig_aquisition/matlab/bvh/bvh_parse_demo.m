%====================================
% Sample code for bvh parsing & motion reconstruction & drawing
%====================================

clear;clc;

% file_path = 'sample/run_1Char00.bvh'
% file_path = 'sample/run_3Char00.bvh'
% file_path = 'sample/run_4Char00.bvh'
% file_path = 'sample/run_5Char00.bvh'
% file_path = 'sample/walk-cycle.bvh'
file_path = 'sample/rand_ycx_9Char00.bvh'

% parsing bvh files
[hierarchy, data, frame_time] = parse_bvh(file_path);

% flatten skelton hierarchy & create skeleton adjascent matrix 
[adjmtx, hierarchy_flat, joint_names] = hierarchy2adjmtx(hierarchy);

% truncate finger joints to save computation time
[index_trunc] = finger_truncate(hierarchy_flat, joint_names);

% compute skeleton from the hierarchy
fig_id = 112;
draw_skeleton(fig_id, hierarchy);

% compute motion
motion = zeros(length(data(:,1)), 4, 3,length(hierarchy_flat));
for t = 1:length(data(:,1))
    dat = data(t,:);
    motion(t, :, :, :) = calc_bvh_posture(hierarchy_flat, index_trunc, dat);
end

% draw motions
fig_id = 123;
draw_bvh_motion(motion, hierarchy_flat, index_trunc, frame_time, fig_id);

