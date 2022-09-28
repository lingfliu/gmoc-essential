clear;clc;

file_path = 'sample/run_1Char00.bvh'

fid = fopen(file_path);



hierarchy = containers.Map;
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
    
    % parse root
    hierarchy('category') = 'root';
    strs = split(strip(line));
    hierarchy('name') = strs{2};
    hierarchy('children') = [];
    
    line = fgetl(fid);
    while feof(fid) ~= 1
        if (regexp(strip(line), '^{')==1)
            bracelets = bracelets + 1;
            break;
        end
    end
    
    line = fgetl(fid);
    while feof(fid) ~= 1
        attr = parse_node_attr(line);
        if (attr.Count > 0)
            keySet = keys(attr);
            for m = 1:length(keySet)
                hierarchy(keySet{m}) = attr(keySet{m});
            end
        else
            if (regexp(strip(line), '^JOINT') == 1)
                [child_hierarchy, bracelets] = parse_node_joint(fid, bracelets);
                child_hierarchy('category') = 'joint';
                strs = split(strip(line));
                child_hierarchy('name') = strs{2};                
                hierarchy('children') = [hierarchy('children'), child_hierarchy];
            elseif (regexp(strip(line), '^End Site') == 1)
                [child_hierarchy, bracelets] = parse_node_end(fid, bracelets);
                hierarchy('children') = [hierarchy('children'), child_hierarchy];
            elseif (regexp(strip(line), '^}') == 1)
                bracelets = bracelets - 1;
                break;
            end
        end
        
        line = fgetl(fid);
    end
    
end
    

