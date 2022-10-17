function [attr, attr_name] = parse_node_attr(line)
%PARSE_NODE_ATTR parse hierarchy node attributes

attr = [];
attr_name = '';
if (regexp(strip(line), '^OFFSET') == 1)
    attr_name = 'offset';
    strs = split(strip(line));
    strs = strs(2:end);
    vals = zeros(1,3);
    for i = 1:length(strs)
        vals(i) = str2double(strs{i});
    end
    attr = vals;    
elseif (regexp(strip(line), '^CHANNELS') == 1)
    attr_name = 'channels';
    strs = split(strip(line));
    strs = strs(3:end);    
    attr = strs;
end

end

