def compact_source_code(source_code)
  s = source_code.lines.map(&:strip).reject(&:empty?).join(';')
  max_length = 240
  if s.length > max_length
    center = s.length / 2
    "...#{s[(center - max_length / 2)...(center + max_length / 2)]}..."
  else
    s
  end
end
