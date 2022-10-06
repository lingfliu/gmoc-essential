function [adjmtx, hierarchy_flat, joint_names] = hierarchy2adjmtx(hierarchy)
%HIERARCHY2ADJMAT 此处显示有关此函数的摘要

cnt = 1;
joint_names{1} = hierarchy.name;

for idx = 1:length(hierarchy.children)
    [cnt, joint_names] = flat(hierarchy.children(idx), cnt, joint_names);
end

adjmtx = zeros(cnt, cnt);

hierarchy_flat = zeros(length(joint_names), 5); %[parent, offset(x,y,z), channels]
hierarchy_flat(1,:) = [0, hierarchy.offset, length(hierarchy.channels)];
cnt = 1;
for idx = 1:length(hierarchy.children)
    [cnt, hierarchy_flat] = flat2(1, hierarchy.children(idx), cnt, hierarchy_flat);
end

a = 1;
end

% hierarchy flatting
function [cnt, joint_names] = flat(hierarchy, cnt, joint_names)

cnt = cnt + 1;
joint_names{cnt} = hierarchy.name;

hierarchy.name
length(hierarchy.children)

if length(hierarchy.children) == 1
    if strcmp(hierarchy.children.category, 'end') == 1
    else
        [cnt, joint_names] = flat(hierarchy.children, cnt, joint_names);        
    end
else
    for idx = 1:length(hierarchy.children)
      [cnt, joint_names] = flat(hierarchy.children(idx), cnt, joint_names);     
    end
end    

end

function [cnt, hierarchy_flat] = flat2(parent_idx, hierarchy, cnt, hierarchy_flat)
    cnt = cnt + 1;
    hierarchy_flat(cnt, :) = [parent_idx, hierarchy.offset, length(hierarchy.channels)];
    
    curr_idx = cnt;
    
    if length(hierarchy.children) == 1
        if strcmp(hierarchy.children.category, 'end') == 1
        else
            [cnt, hierarchy_flat] = flat2(curr_idx, hierarchy, cnt, hierarchy_flat);
        end
    else
        for idx = 1:length(hierarchy.children)
            [cnt, hierarchy_flat] = flat2(curr_idx, hierarchy, cnt, hierarchy_flat);
        end
    end
end

