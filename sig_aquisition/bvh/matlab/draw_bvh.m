function [] = draw_bvh(fig_id, hierarchy,data, frameTime)
%DRAW_BVH draw bvh animation files

for idx = 300:length(data(:,1))
    dat = data(idx,:);
    motion = dat(1:6);
    p_root = motion(1:3)';
    rmat_root = calc_rmat(motion(4)/180*pi, motion(5)/180*pi, motion(6)/180*pi);
    p_root = rmat_root * p_root;
    
    dat = dat(7:end);
    for m = 1:length(hierarchy.children)
        dat = draw_motion(fig_id, p_root, rmat_root, hierarchy.children(m), dat);
    end
    
    break
    pause(0.1)
end
end

