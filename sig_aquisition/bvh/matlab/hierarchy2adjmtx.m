function [adjmtx, hierarchy_flat, joint_names] = hierarchy2adjmtx(hierarchy)
% HIERARCHY2ADJMTX convert hierarchy to adjascent matrix with other
% conversion outputs
% input:
%   hierarchy: skeleton hierarchy parsed from bvh file
% output:
%   adjmtx: adjascent matrix with edge weight 1
%   hierarchy_flat: flatten hierarchy, entry formatted as [parent_idx, offset(x,y,z), channels, data_offset]

cnt = 1;
joint_names{1} = hierarchy.name;

for idx = 1:length(hierarchy.children)
    [cnt, joint_names] = flat(hierarchy.children(idx), cnt, joint_names);
end

adjmtx = zeros(cnt, cnt);

hierarchy_flat = zeros(length(joint_names), 6); %[parent, offset(x,y,z), channels]
hierarchy_flat(1,:) = [0, hierarchy.offset, length(hierarchy.channels), 1]; % end node, channel = 0
cnt = 1;
data_offset = 7;
for idx = 1:length(hierarchy.children)
    [cnt, hierarchy_flat, data_offset] = flat2(1, hierarchy.children(idx), cnt, hierarchy_flat, data_offset);
end

end

% get joints flatting
function [cnt, joint_names] = flat(hierarchy, cnt, joint_names)

cnt = cnt + 1;
joint_names{cnt} = hierarchy.name;

% hierarchy.name
% length(hierarchy.children)

if length(hierarchy.children) == 1
    if strcmp(hierarchy.children.category, 'end') == 1
        [cnt, joint_names] = flat(hierarchy.children, cnt, joint_names);        
    else
        [cnt, joint_names] = flat(hierarchy.children, cnt, joint_names);        
    end
else
    for idx = 1:length(hierarchy.children)
      [cnt, joint_names] = flat(hierarchy.children(idx), cnt, joint_names);     
    end
end    

end

function [cnt, hierarchy_flat, data_offset] = flat2(parent_idx, hierarchy, cnt, hierarchy_flat, data_offset)
    if strcmp(hierarchy.name, 'end') == 1
       cnt = cnt + 1; 
       hierarchy_flat(cnt, :) = [parent_idx, hierarchy.offset, length(hierarchy.channels), -1];
    else
        cnt = cnt + 1;
        hierarchy_flat(cnt, :) = [parent_idx, hierarchy.offset, length(hierarchy.channels), data_offset];
        data_offset = data_offset + length(hierarchy.channels);
        
        curr_idx = cnt;
        if length(hierarchy.children) == 1
            if strcmp(hierarchy.children.category, 'end') == 1
                [cnt, hierarchy_flat, data_offset] = flat2(curr_idx, hierarchy.children, cnt, hierarchy_flat, data_offset);
            else
                [cnt, hierarchy_flat, data_offset] = flat2(curr_idx, hierarchy.children, cnt, hierarchy_flat, data_offset);
            end
        else
            for idx = 1:length(hierarchy.children)
                [cnt, hierarchy_flat, data_offset] = flat2(curr_idx, hierarchy.children(idx), cnt, hierarchy_flat, data_offset);
            end
        end
    end
end

