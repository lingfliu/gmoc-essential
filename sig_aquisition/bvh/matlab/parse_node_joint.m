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
            hierarchy.children = [hierarchy.children, child_hierarchy];
        elseif (regexp(strip(line), '^End Site') == 1)
            [child_hierarchy, bracelets] = parse_node_end(fid, bracelets);
            child_hierarchy.category = 'end';
            child_hierarchy.name = 'end';
            hierarchy.children = [hierarchy.children, child_hierarchy];
        elseif (regexp(strip(line), '^}') == 1)
            bracelets = bracelets - 1;
            break;
        end
    end
    
    line = fgetl(fid);
end

end

