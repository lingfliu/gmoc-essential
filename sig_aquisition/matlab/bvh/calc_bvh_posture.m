function posture = calc_bvh_posture(hierarchy_flat, index_trunc, dat)
%CALC_BVH_POSTURE calculate posture from bvh data
% return posture: [4,4,num_joints]

% input:
% hierarchy_flat: [parent_idx, offset(x,y,z), channels, data_offset]

rmat = zeros(3,3, length(hierarchy_flat));
posture = zeros(4,3, length(hierarchy_flat));
for i = 1:length(index_trunc)
    idx = index_trunc(i);
    chn = hierarchy_flat(idx, 5);
    d = hierarchy_flat(idx,6);
    
    if hierarchy_flat(idx,1) == 0 % root
        pos_parent = [0,0,0]';
    else
        pos_parent = posture(4,1:3,hierarchy_flat(idx,1))';
    end    
        
    if chn == 6
        pos = dat(d:d+2)';
        rotate = dat(d+3:d+5);
        if hierarchy_flat(idx,1) == 0 % root
            rmat(1:3, 1:3, idx) =  calc_rmat(rotate(1)/180*pi, rotate(2)/180*pi, rotate(3)/180*pi);
        else
            pos = pos_parent+rmat(:,:,hierarchy_flat(idx, 1))*pos;
            rmat(1:3, 1:3, idx) =  rmat(:,:, hierarchy_flat(idx,1))*calc_rmat(rotate(1)/180*pi, rotate(2)/180*pi, rotate(3)/180*pi);
        end
        posture(4,1:3,idx) = pos;
    elseif chn == 3
        pos = hierarchy_flat(idx, 2:4)';
        pos = pos_parent+rmat(:,:,hierarchy_flat(idx, 1))*pos;
        rotate = dat(d:d+2);
        rmat(1:3, 1:3, idx) =  squeeze(rmat(:,:, hierarchy_flat(idx,1)))*calc_rmat(rotate(1)/180*pi, rotate(2)/180*pi, rotate(3)/180*pi);
        posture(4,1:3,idx) = pos;
    elseif chn == 0
        pos = hierarchy_flat(idx, 2:4)';
        pos = pos_parent+rmat(:,:,hierarchy_flat(idx, 1))*pos;
        posture(4,1:3,idx) = pos;
    end
end

posture(1:3,1:3,:) = rmat;
end

