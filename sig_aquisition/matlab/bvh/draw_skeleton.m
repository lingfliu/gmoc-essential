function [] = draw_skeleton(fig_id, hierarchy)
%DRAW_SKELETON �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
p_root = hierarchy.offset;

for c = 1:length(hierarchy.children)
    draw_skeleton_joint(fig_id, p_root,  hierarchy.children(c));
end

end

