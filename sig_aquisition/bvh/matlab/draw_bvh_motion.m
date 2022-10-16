function [] = draw_bvh_motion(motion,hierarchy_flat, index_trunc, frame_time, fig_id)
%DRAW_BVH_MOTION 此处显示有关此函数的摘要
%   此处显示详细说明
figure(fig_id);

x = motion(:,4,1,:);
x = x(:);
y = motion(:,4,2,:);
y= y(:);
z = motion(:,4,3,:);
z = y(:);
axis_range = [min(x)-50, max(x)+50, min(y)-50, max(y)+50, min(z)-50, max(z)+50];

for t = 1:length(motion(:,1,1,1))   
   mot = squeeze(motion(t, :, :, :));
   
   for i = 2:length(index_trunc)
       if (i == 2)
           hold off
       else
           hold on
           view(0,90)
           axis(axis_range)
       end
       idx = index_trunc(i);
       
       p = [mot(4, 1:3, hierarchy_flat(idx,1)); mot(4, 1:3, idx)];
       plot3(p(:,1), p(:,2),p(:,3));
   end
   pause(frame_time)
end

end
