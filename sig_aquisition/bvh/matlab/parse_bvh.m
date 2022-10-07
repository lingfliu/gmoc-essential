function [hierarchy, data, frameTime] = parse_bvh(file_path)
%PARSE_BVH biovision hierarchy and data parsing
% input
%   file_path
% returns 
%   hierarchy: skeleton hierarchy
%   data: mocap data ordered by hierarchy spec.
%   frameTime: frame sampling time in seconds

hierarchy = struct('category','','name','','offset',[], 'channels',[],'children',[]);
data = [];

fid = fopen(file_path);

if fid < 0
    return
end

%============================
%hierarchy parsing
%============================
foundHierarchy = false;

line = fgetl(fid);
while feof(fid) ~= 1
    if (regexp(strip(line), '^HIERARCHY') == 1)
        foundHierarchy = true;
        break;
    end
    line = fgetl(fid);
end

if (foundHierarchy)
    bracelets = 0;
    foundRoot = false;
    
    line = fgetl(fid);
    while feof(fid) ~= 1
        if (regexp(strip(line), '^ROOT ') == 1)
            foundRoot = true;
            break;
        end
        line = fgetl(fid);
    end
    
    if ~foundRoot
        fclose(fid);
        return
    end
    
    % parse root
    hierarchy.category = 'root';
    strs = split(strip(line));
    hierarchy.name = strs{2};
    hierarchy.children = [];
    
    line = fgetl(fid);
    while feof(fid) ~= 1
        if (regexp(strip(line), '^{')==1)
            bracelets = bracelets + 1;
            break;
        end
    end
    
    line = fgetl(fid);
    while feof(fid) ~= 1
        [attr, attr_name] = parse_node_attr(line);
        if strcmp(attr_name, 'offset')
            hierarchy.offset = attr;
        elseif strcmp(attr_name, 'channels')
            hierarchy.channels = attr;
        else
            if (regexp(strip(line), '^JOINT') == 1)
                [child_hierarchy, bracelets] = parse_node_joint(fid, bracelets);
                child_hierarchy.category = 'joint';
                strs = split(strip(line));
                child_hierarchy.name = strs{2};
                hierarchy.children = [hierarchy.children child_hierarchy];
            elseif (regexp(strip(line), '^End Site') == 1)
                [child_hierarchy, bracelets] = parse_node_end(fid, bracelets);
                child_hierarchy.category = 'end';
                hierarchy.children = [hierarchy.children, child_hierarchy];
            elseif (regexp(strip(line), '^}') == 1)
                bracelets = bracelets - 1;
                break;
            end
        end
        
        line = fgetl(fid);
    end
    
    if bracelets ~= 0
        hierarchy = struct('category','','name','','offset',[], 'channels',[],'children',[]);
        fclose(fid);
        return
    end
    
 
    %============================
    %motion parsing
    %============================
    foundMotion = false;
    line = fgetl(fid);
    while feof(fid) ~= 1
         if regexp(strip(line), '^MOTION')==1
             foundMotion = true;
             break;
         end
         line = fgetl(fid);
    end
    
    if ~foundMotion
        fclose(fid);
        return
    end
    
    frames = -1;
    line = fgetl(fid);
    while feof(fid) ~= 1
         if regexp(strip(line), '^Frames')==1
             strs = split(line);
             frames = str2double(strs{2});
             break;
         end
         line = fgetl(fid);
    end
    
    frameTime = -1;
    line = fgetl(fid);
    while feof(fid) ~= 1
         if regexp(strip(line), '^Frame Time')==1
             strs = split(line);
             frameTime = str2double(strs{3});
             break;
         end
         line = fgetl(fid);
    end
    
    cnt = 0
    line = fgetl(fid);
    while feof(fid) ~= 1
         strs = split(strip(line));
         vals = zeros(1, length(strs));
         for m = 1:length(strs)
             vals(m) = str2double(strs{m});
         end
         data = [data; vals];
         line = fgetl(fid);
    end 
end

fclose(fid);
end

