def xor?(arg1, arg2)
  !!(arg1 && !arg2) || (!arg1 && arg2)
end

# note that the double exclaimation marks are needed to ensure that the output is a boolean value.
# truthy --> false --> true