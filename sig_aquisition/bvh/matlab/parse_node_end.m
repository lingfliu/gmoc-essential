function [hierarchy, bracelets] = parse_node_end(fid, bracelets)
%PARSE_NODE_END parse end site hierarchy
% 
hierarchy = containers.Map;

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
    
end

