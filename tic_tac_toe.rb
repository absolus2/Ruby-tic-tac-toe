module Victory
  def h_victory?(display, table)
    table.each do |array|
      return true if array.all? { |item| item == display }
    end
  end

  def v_victory?(display, table)
    v_victory = []
    continue = 0
    while continue != 3
      array = []
      table.flatten.each_slice(3) { |n| array.push(n[continue]) }
      v_victory.push(array)
      continue += 1
    end
    v_victory.each { |element| return true if element.all? { |item| item == display } }
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

  private

  def check_diag(lista,listb, display)
    return lista.all? { |item| item == display } if lista.length >= 3
    return listb.all? { |item| item == display } if listb.length >= 3
  end
end

class Game
  attr_accessor :turn, :table

  include Victory

  def initialize(turn, table)
    @turn = turn
    @table = table
  end

  def intro
    puts "Hello, this is tic tac toe, First player Will be X and will play every
    odd turn, Second player will be O and play every even turn!, Good luck!"
  end

  def display_table
    @table.each { |i| p i }
  end

  def check_victory(display)
    if (h_victory?(display, @table) == true) ||
       (v_victory?(display, @table) == true) ||
       d_victory?(display, @table) == true
      true
    end
  end

  def check_turn
    @turn
  end

  def change_table(number, display)
    @table.each do |array|
      array.map! do |element|
        if element == number.to_i
          element = display
        else
          element
        end
      end
    end
  end

  def again?
    puts "\n Start Again?(y/n)"
    answer = gets
    if answer == "y\n"
      game_play()
    else
      exit
    end
  end
end

class Player
  def initialize(display, odd)
    @display = display
    @odd = odd
  end

  def check_display
    @display
  end
end

def game_play
  table = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  new_game = Game.new(1, table)
  won_draw = false

  new_game.intro
  player1 = Player.new('X', true)
  player2 = Player.new('O', false)

  new_game.display_table
  while won_draw != true
    if new_game.check_turn.odd?
      play_turn(player1, new_game)
    else
      play_turn(player2, new_game)
    end

    if new_game.turn > 3
      if new_game.check_victory(player1.check_display) == true
        puts 'Congratz You WON PLAYER1!!!'
        won_draw = true
      elsif new_game.check_victory(player2.check_display) == true
        puts 'Congratz YOU WON PLAYER2!!!'
        won_draw = true
      end
    end
  end
  new_game.again?
end

def play_turn(player, game)

  puts "Your turn player #{player.check_display}, pick a number to place your #{player.check_display}"
  number1 = gets
  game.change_table(number1, player.check_display)
  puts "turn #{game.check_turn}"
  game.display_table
  game.turn += 1
end

game_play()