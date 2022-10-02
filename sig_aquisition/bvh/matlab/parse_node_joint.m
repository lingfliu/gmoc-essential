function [hierarchy, bracelets] = parse_node_joint(fid, bracelets)
%PARSE_NODE_JOINT parse joint hierarchy

% hierarchy 
hierarchy = struct('category','','name','','offset',[], 'channels',[],'children',[]);

line = fgetl(fid);

while feof(fid) ~= 1
    if (regexp(strip(line), '^{')==1)
        bracelets = bracelets + 1;
        break
    end
end

line = fgetl(fid);
while feof(fid) ~= 1
    attr = parse_node_attr(line);
    if (attr.Count > 0)
        keySet = keys(attr);
        for m = 1:length(keySet)
            if (regexp(keySet{m},'offset')==1)
                hierarchy.offset = attr(keySet{m});
            elseif (regexp(keySet{m}, 'channels')==1)
                hierarchy.channels = attr(keySet{m});
            end
        end
    else
        if (regexp(strip(line), '^JOINT') == 1)
            [child_hierarchy, bracelets] = parse_node_joint(fid, bracelets);
            child_hierarchy.category = 'joint';
            strs = split(strip(line));
            child_hierarchy.name = strs{2};
            hierarchy.children = [hierarchy.children, child_hierarchy];
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

end

