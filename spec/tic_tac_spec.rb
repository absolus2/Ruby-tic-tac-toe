# frozen_string_literal: true

require_relative '../lib/tic_tac_toe'

describe TicTacToe do

  subject(:game) { described_class.new('1', '2') }

  describe '#change_player' do
    context 'When starting new game' do
      it 'expect game to receive method' do
        expect(game).to receive(:change_player).once
        game.change_player('1', 'y')
      end

      it 'change the player1 value from 1 to P when answer is yes' do
        expect { game.change_player('1', 'y', 'P') }.to change { game.instance_variable_get(:@player1) }.from('1').to('P')
      end

      it 'change the player2 value from 2 to D when answer is yes ' do
        expect { game.change_player('2', 'y', 'D') }.to change { game.instance_variable_get(:@player2) }.from('2').to('D')
      end

      it 'change the player1 value from 1 to X when answer is no' do
        expect { game.change_player('1', 'n') }.to change { game.instance_variable_get(:@player1) }.from('1').to('X')
      end
      it 'change the player2 value from 2 to X when answer is no' do
        expect { game.change_player('2', 'n') }.to change { game.instance_variable_get(:@player2) }.from('2').to('O')
      end
    end
  end

  describe '#place_player' do

    context 'When placing a player in the board' do
      it 'it change the value of the table on key "1" to the player in this case "X"' do
        expect { game.place_player('X', 1) }
          .to (change { game.instance_variable_get(:@table)[1] }.from('').to('X'))
      end

    end

    context 'When placing a player in an already occupied space' do

      before do
        allow(game).to receive(:gets).and_return('1', '2')
        table = { 1 => 'X', 2 => '', 3 => '', 4 => 'X', 5 => '', 6 => '', 7 => 'X', 8 => '', 9 => '' }
        game.instance_variable_set(:@table, table)
      end

      it 'returns a message when the place is already occupied' do
        expect(game).to receive(:puts).with('That place is already occupied, please pick another!').twice
        game.place_player('X', 1)
      end

    end

  end

  describe '#default_players' do
    it 'changes the initial values of player1 and player2 to "X" & "O"' do
      expect { game.default_players }.to (change { game.instance_variable_get(:@player1) })
        .and (change { game.instance_variable_get(:@player2) })
    end
  end

  describe '#victory?' do

    context 'Check win conditions vertical' do
      it 'true when a player has a vertical victory on first column' do
        table = { 1 => 'X', 2 => '', 3 => '', 4 => 'X', 5 => '', 6 => '', 7 => 'X', 8 => '', 9 => '' }
        game.instance_variable_set(:@table, table)
        expect(game.victory?('X')).to eq(true)
      end

      it 'true when a player has a vertical victory on second  column' do
        table = { 1 => '', 2 => 'X', 3 => '', 4 => '', 5 => 'X', 6 => '', 7 => '', 8 => 'X', 9 => '' }
        game.instance_variable_set(:@table, table)
        expect(game.victory?('X')).to eq(true)
      end

      it 'true when player has vertical victory on the third and final  column' do
        table = { 1 => '', 2 => '', 3 => 'X', 4 => '', 5 => '', 6 => 'X', 7 => '', 8 => '', 9 => 'X' }
        game.instance_variable_set(:@table, table)
        expect(game.victory?('X')).to eq(true)
      end
    end

    context 'check win conditions horizontal' do
      it 'true when player has horizontal victory on the first row' do
        table = { 1 => 'X', 2 => 'X', 3 => 'X', 4 => '', 5 => '', 6 => '', 7 => '', 8 => '', 9 => '' }
        game.instance_variable_set(:@table, table)
        expect(game.victory?('X')).to eq(true)
      end

      it 'true when player has horizontal victory on the second row' do
        table = { 1 => '', 2 => '', 3 => '', 4 => 'X', 5 => 'X', 6 => 'X', 7 => '', 8 => '', 9 => '' }
        game.instance_variable_set(:@table, table)
        expect(game.victory?('X')).to eq(true)
      end

      it 'true when player has horizontal victory on the third and final row' do
        table = { 1 => '', 2 => '', 3 => '', 4 => '', 5 => '', 6 => '', 7 => 'X', 8 => 'X', 9 => 'X' }
        game.instance_variable_set(:@table, table)
        expect(game.victory?('X')).to eq(true)
      end
    end

    context 'Check win condition diagonal' do
      it 'true when player has diagonal victory on the left side' do
        table = { 1 => 'X', 2 => '', 3 => '', 4 => '', 5 => 'X', 6 => '', 7 => '', 8 => '', 9 => 'X' }
        game.instance_variable_set(:@table, table)
        expect(game.victory?('X')).to eq(true)
      end

      it 'true when player has diagonal victory on the right side' do
        table = { 1 => '', 2 => '', 3 => 'X', 4 => '', 5 => 'X', 6 => '', 7 => 'X', 8 => '', 9 => '' }
        game.instance_variable_set(:@table, table)
        expect(game.victory?('X')).to eq(true)
      end
    end
  end

  describe '#Intro' do
    # no test a mainly put method with a call to #change_player
  end

  describe '#draw?' do
    context 'When the board is full but no winner is establish' do
      before do
        table = { 1 => 'X', 2 => 'O', 3 => 'X', 4 => 'O', 5 => 'X', 6 => 'O', 7 => 'X', 8 => 'O', 9 => 'X' }
        game.instance_variable_set(:@table, table)
        game.instance_variable_set(:@player1, 'X')
        game.instance_variable_set(:@player2, 'O')
      end

      it 'returns true for a draw in the game' do
        expect(game.draw?).to eq(true)
      end
    end

    context 'When the board is not full' do
      before do
        table = { 1 => 'X', 2 => 'O', 3 => 'X', 4 => 'O', 5 => 'X', 6 => 'O', 7 => 'X', 8 => 'O', 9 => '' }
        game.instance_variable_set(:@table, table)
        game.instance_variable_set(:@player1, 'X')
        game.instance_variable_set(:@player2, 'O')
      end

      it 'returns nil' do
        expect(game.draw?).to eq(nil)
      end
    end
  end

end