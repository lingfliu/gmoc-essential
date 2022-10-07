function [index_trunc] = finger_truncate(hierarchy_flat, joint_names)
% Exclude fingers to accelerate skeleton reconstruction
% input
%   hierarchy_flat: flatten hierarchy
%   joint_names: ordered joint names
% output
%   index_trunc: truncated indice
% 
% The regexp is compatible for perceptron neuron generated bvh files
% see also HIERARCHY2ADJMTX
str = 'HandThumb|HandIndex|HandMiddle|HandRing|HandPinky'; 

finger_cnt = 0;
finger_idx = [];
for i = 1:length(joint_names)   
    if ~isempty(regexp(joint_names{i}, str))
        finger_cnt = finger_cnt + 1;
        finger_idx(finger_cnt) = i;            
    end
end

cnt = 0;
index_trunc = [1];

for i = 1:length(joint_names)
    if ~ismember(i, finger_idx) && ~ismember(hierarchy_flat(i,1), finger_idx)
        cnt = cnt + 1;
        index_trunc(cnt) = i;
    end
end

end

