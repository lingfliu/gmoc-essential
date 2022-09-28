function attr = parse_node_attr(line)
%PARSE_NODE_ATTR parse hierarchy node attributes
attr = containers.Map;
if (regexp(strip(line), '^OFFSET') == 1)
    strs = split(line);
    strs = strs(1:end);
    attr('offset') = str2double(strs);
elseif (regexp(strip(line), '^CHANNELS') == 1)
    strs = split(line);
    strs = strs(2:end);
    attr('channels') = strs;
end

end

