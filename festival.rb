a = [1, 2, 3, 1, 2, 3]
l = 3
a = [1, 2, 3, 1, 2, 3]
l = 2
min = 100
a.size.times do |s|
  puts s
  l.upto(a.size-s) do |n|
    total = 0
    n.times {|i| total += a[s+i]}
    mean = total*1.0/n
    min =  mean if min > mean
  end

end
puts min
