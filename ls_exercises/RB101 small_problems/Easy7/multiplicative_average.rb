def show_multiplicative_average(num_arr)
  "%.3f" % (num_arr.reduce(:*) / num_arr.size.to_f)
end
