function [] = draw_skeleton(fig_id, hierarchy)
%DRAW_SKELETON 此处显示有关此函数的摘要
%   此处显示详细说明
p_root = hierarchy.offset;

for c = 1:length(hierarchy.children)
    draw_skeleton_joint(fig_id, p_root,  hierarchy.children(c));
end

end

