require_relative 'setup'
class Turn

  puts "=============COMPUTER BOARD============="

  #computer_placement

  puts "==============PLAYER BOARD=============="

  #player_placement

  puts "Enter the coordinate for your shot:"

  setup.gather_input

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