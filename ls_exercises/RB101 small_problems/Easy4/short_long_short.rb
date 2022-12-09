def short_long_short(string1, string2)
  small, big = [string1, string2].minmax_by(&:size)
  small + big + small
end
