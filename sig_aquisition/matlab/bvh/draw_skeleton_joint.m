function [] = draw_skeleton_joint(fig_id,p_parent, hierarchy)
%DRAW_SKELETON_JOINT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

figure(fig_id)
hold on
p_current = p_parent + hierarchy.offset;
p = [p_parent', p_current'];
plot3(p(1,:), p(2,:), p(3,:));

for c = 1:length(hierarchy.children)   
    draw_skeleton_joint(fig_id, p_current, hierarchy.children(c));
end
end

