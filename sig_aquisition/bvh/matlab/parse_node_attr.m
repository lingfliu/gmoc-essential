function attr = parse_node_attr(line)
%PARSE_NODE_ATTR parse hierarchy node attributes
attr = containers.Map;
if (regexp(strip(line), '^OFFSET') == 1)
    strs = split(line);
    strs = strs(3:end);
    vals = zeros(1,3);
    for i = 1:length(strs)
        vals(i) = str2double(strs{i});
    end
    attr('offset') = vals;
elseif (regexp(strip(line), '^CHANNELS') == 1)
    strs = split(line);
    strs = strs(4:end);
    attr('channels') = strs;
end

end

