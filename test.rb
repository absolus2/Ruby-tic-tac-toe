def d_victory(display, table)
  d_victory = []
  d_victory_l = []
  table.flatten.each_with_index do |element, index|
    d_victory.push(element) if element == display && index.even? && !index.zero? && index != 8
    d_victory_l.push(element) if element == display && index.even? && index != 2 && index != 6
  end
  p d_victory
  d_victory.all? { |item| item == display } unless d_victory.length < 3
end

def d_victory?(display, table)
  d_victory = []
  l_victory = []
  table.flatten.each_with_index do |element, i|
    d_victory.push(element) if !i.zero? && i != 8 && element == display && i.even?
    l_victory.push(element) if i != 2 && i != 6 && element == display && i.even?
  end
  check_diag(d_victory, l_victory, display)
end

def check_diag(lista,listb, display)
  return lista.all? { |item| item == display } if lista.length >= 3
  return listb.all? { |item| item == display } if listb.length >= 3 
end

table = [[1,2,'x'],[4,'x',6],['x', 8, 9]]
p d_victory?('x', table)