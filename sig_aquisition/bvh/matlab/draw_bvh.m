function [] = draw_bvh(fig_id, hierarchy,data, frameTime)
%DRAW_BVH draw bvh animation files

fid = 1;
for idx = 1:50:length(data(:,1))        
    figure(fid);
    axis equal
    hold on
    dat = data(idx,:);
    motion = dat(1:6);
    p_root = motion(1:3)';
    rmat_root = calc_rmat(motion(4)/180*pi, motion(5)/180*pi, motion(6)/180*pi);
    p_root = rmat_root * p_root;
    
    dat = dat(7:end);
    for m = 1:length(hierarchy.children)        
        dat = draw_motion(fid, p_root, rmat_root, hierarchy.children(m), dat);
    end
    
    fid = fid + 1;
    break
%     pause(0.5)
%     figure(fig_id);
%     clf(fig_id)
end
end

