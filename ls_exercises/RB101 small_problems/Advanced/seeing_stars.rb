def stars(n)
	half = (n - 3) / 2
	(0..half).each do |i| # top
		print ' ' * i
		print '*' + (' ' * (half - i) + '*') * 2
		puts
	end
	puts ('*' * n) # middle
	half.downto(0) do |i| # bottom
		print ' ' * i
		print '*' + (' ' * (half - i) + '*') * 2
		puts
	end
end

stars(9)