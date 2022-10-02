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
    attr = parse_node_attr(strip(line));
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
        if (regexp(strip(line), '^}')==1)
            bracelets = bracelets - 1;
            break
        end
    end
    line = fgetl(fid);
end

