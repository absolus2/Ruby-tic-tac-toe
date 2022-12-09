require 'colorize'

class TicTacToe
  
  def initialize(player1 = '1', player2 = '2')
    @player1 = player1
    @player2 = player2
    @table = Hash[(1..9).map { |num| [num, "#{}".to_s] }]
    @turn = 1
    @columns = [[1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 5, 9], [3, 5, 7]]
    @flag = false
  end

  def play
    intro
    until @flag == true
      display_board
      play_turn
      game_over
    end
  end

  def draw?(array = [])
    @table.each_value do |value|
      array.push(value) if value == @player1
      array.push(value) if value == @player2
    end
    array.all? { |item| item != '' } if array.length == @table.length
  end

  def game_over
    if victory?(@player1)
      puts "Congratulations player `#{@player1}`!! YOU WON!!"
      @flag = true
      display_board
    elsif victory?(@player2)
      puts "Congratulations player `#{@player2}`!! YOU WON!!"
      @flag = true
      display_board
    elsif draw?
      puts 'Its a draw GAME OVER!!!'
      @flag = true
      display_board
    end
  end

  def play_turn
    if @turn.odd?
      move_player(@player1)
    elsif @turn.even?
      move_player(@player2)
    end
    @turn += 1
  end

  def move_player(player)
    p "Go ahead, player '#{player}', Place your mark in the Board"
    move = gets.chomp.to_i
    place_player(player, move)
  end

  def pick_player
    puts "Hello, would you like to pick your characters, (y/n)?, if not game will begin.
    player1 will be the 'X' and player2 will be the 'o'"
    answer = gets.chomp
    change_player(@player1, answer)
    change_player(@player2, answer)
  end

  def place_player(player, move)
    return @table[move] = player if @table[move] == ''

    puts 'That place is already occupied, please pick another!'
    movement = gets.chomp.to_i
    place_player(player, movement)
  end

  def change_player(player, answer, value = '')
    case answer
    when 'y'
      until value.match((/\D/))
        puts "Please input a character or symbol player#{player},numbers not accepted."
        value = gets.chomp
      end
      player.include?('1') ? @player1 = value : @player2 = value
    else
      default_players
    end
  end

  def default_players
    @player1 = 'X'
    @player2 = 'O'
  end

  def victory?(player = '', counted = [], count = 0)
    @columns.length.times do
      @table.each do |key, value|
        @columns[count].each do |item|
          counted.push(value) if key == item
        end
      end
      counted.all? { |item| item == player } ? break : counted = []

      count += 1
    end
    check_all?(counted, player)
  end

  private

  def check_all?(counted, player)
    if counted.any?
      counted.all? { |item| item == player }
    else
      false
    end
  end

  def intro
    puts 'Hello, Welcome to tic tac toe, Your game will begin soon'
    puts 'You can play by picking the cell to put on your player'
    puts 'every cell goes from 1 to 9, so the very first cell would be the top left, and the last one would be the bottom right.'
    sleep(1)
    pick_player
  end

  def display_board
    puts '//////////////'
    puts "/ #{@table[1].colorize(:red)} /""/ #{@table[2].colorize(:red)} /""/ #{@table[3].colorize(:red)} /"
    puts '//////////////'
    puts "/ #{@table[4].colorize(:red)} /""/ #{@table[5].colorize(:red)} /""/ #{@table[6].colorize(:red)} /"
    puts '//////////////'
    puts "/ #{@table[7].colorize(:red)} /""/ #{@table[8].colorize(:red)} /""/ #{@table[9].colorize(:red)} /"
    puts '//////////////'
  end

end

bored = TicTacToe.new
bored.play