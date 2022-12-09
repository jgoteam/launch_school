def greetings(name_arr, job_hsh)
  name = name_arr.join(' ')
  job = "#{job_hsh[:title]} #{job_hsh[:occupation]}"
  "Hello #{name}! Nice to have a #{job} around."
end
