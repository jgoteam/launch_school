GRADE_HSH = { (0...60).to_a => 'F', (60...70).to_a => 'D', (70...80).to_a => 'C',
              (80...90).to_a => 'B', (90...100).to_a => 'A', (100...500).to_a => 'A+' }

def get_grade(*grades)
  avg = grades.sum / grades.size
  GRADE_HSH.keys.each { |range| return GRADE_HSH[range] if range.include?(avg) }
end
