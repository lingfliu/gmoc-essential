function dat = draw_motion(fig_id, p_parent, rmat_parent, hierarchy, data);
%DRAW_MOTION 此处显示有关此函数的摘要
%   此处显示详细说明
motion = data(1:6);
rmat = calc_rmat(motion(4)/180*pi, motion(5)/180*pi, motion(6)/180*pi);

p_current = p_parent + rmat_parent*rmat*motion(1:3)';

figure(fig_id)
hold on
p = [p_parent, p_current];
plot3(p(1,:), p(2,:), p(3,:));

dat = data(7:end);
for idx = 1:length(hierarchy.children)
    if regexp(hierarchy.children(idx).category, 'end') == 1
        p_end = p_current + rmat_parent*rmat*hierarchy.children(idx).offset';
        figure(fig_id)
        hold on
        p = [p_current, p_end];
        plot3(p(1,:), p(2,:), p(3,:));
    elseif regexp(hierarchy.children(idx).category, 'joint') == 1
        dat = draw_motion(fig_id, p_current, rmat_parent*rmat, hierarchy.children(idx), dat);
    end
end
end

