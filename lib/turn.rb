require_relative 'setup'
class Turn
  setup = Setup.new

  setup.computer_setup
  setup.player_setup

  puts "=============COMPUTER BOARD============="

  puts setup.computer_board.render

  puts "==============PLAYER BOARD=============="

  puts setup.player_board.render(true)

  puts "Enter the coordinate for your shot:"

  shot_coord = setup.gather_input

  #check valid coordinate

  puts "Please enter a valid coordinate:"

  #fire_upon a cell, both player and computer

  puts "Your shot on A CELL was a ----.
        My shot on A CELL was a ----."

  #end game with

  puts "I won!"

  #or

  puts "You won!"
end