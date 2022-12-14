function [hierarchy, bracelets] = parse_node_end(fid, bracelets)
%PARSE_NODE_END parse end site hierarchy
% 
hierarchy = struct('category','','name','','offset',[], 'channels',[],'children',[]);

line = fgetl(fid);
while feof(fid) ~= 1
    if (regexp(strip(line), '^{')==1)
        bracelets = bracelets + 1;
        break
    end
    
    line = fgetl(fid);    
end

line = fgetl(fid);
while feof(fid) ~= 1
    [attr, attr_name] = parse_node_attr(line);
    if strcmp(attr_name, 'offset')
        hierarchy.offset = attr;
    elseif strcmp(attr_name, 'channels')
        hierarchy.channels = attr;
    else
        if (regexp(strip(line), '^}')==1)
            bracelets = bracelets - 1;
            break
        end
    end
    line = fgetl(fid);
end

