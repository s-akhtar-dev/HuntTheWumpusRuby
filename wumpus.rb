# PROGRAMMERS: Sarah Akhtar and Kieran Monks
# DATE: October 14th, 2024
# FILE: wumpus.rb
# DESCRIPTION: This file implements the Hunt the Wumpus game
# ----------------------------------------------------------- #

# === Game Classes and State Variables ===

# Location class construct representing a location type in the maze
# - Includes a print method for outputting a hidden 'O' maze coordinate
# - Includes a visit method for outputting a blank line as default output
class Location
  # Prints the symbol for the current location
  # @return [String] the symbol representing the hidden location
  def print
    "O"
  end

  # Prints a newline as output for organization
  # @return [void]
  def visit
    puts
  end
end

# Pit class construct representing a pit in the maze
# - Inherits from Location to allow outputting empty locations
# - Contains a method to print the pit, represented as 'p'
# - Contains a method for outputting a loss message for pits
class Pit < Location
  # Prints the symbol for a pit as represented as 'p'
  # @return [String] the symbol representing a pit
  def print
    "p"
  end

  # Prints a loss message when landing on pit
  # @return [void]
  def visit
    puts "You fell into a dark pit where the wumpus children live. You lost!"
  end
end

# Wumpus class construct representing the wumpus in the maze
# - Inherits from Location to allow outputting empty locations
# - Contains a method to print the wumpus, represented as 'w'
# - Contains a method for outputting a loss message for wumpus
class Wumpus < Location
  # Prints the symbol for the wumpus as represented by 'w'
  # @return [String] the symbol representing the wumpus
  def print
    "w"
  end

  # Prints a loss message when landing on wumpus
  # @return [void]
  def visit
    puts "You fell in the depths of the wumpus tummy. You lost!"
  end
end

# Game class containing the Hunt the Wumpus game logic
# - Includes methods for game initialization, play loop, map generation, and player movement
# - Includes methods for loss detection, hint system, and arrow shooting mechanics
class Game
  # === Hunt the Wumpus Game Initialization Method ===

  # Initializes the game state from new instance
  # @return [void]
  def initialize
    # Creates a 2D array for game maze and player start location
    @maze = Array.new(4) { Array.new(6) { Location.new } }
    @player_row = 3
    @player_col = 0
    @game_over = false
    
    #Create new game from pits and wumpus
    place_pits
    place_wumpus
  end

  # === Hunt the Wumpus Main Game Loop ===

  # Initializes a new game session to play
  # @return [void]
  def play
    puts "Hunt down the wumpus and try to shoot it with your arrow!\n\n"
    
    # Continues game until player wins/losses
    until @game_over
      print_maze
      move
      check_location
      puts
    end

    print_final_maze
  end

  private

  # === Hunt the Wumpus Map Generation Methods ===

  # Places pits randomly in the game maze
  # @return [void]
  def place_pits
    4.times do
      row = rand(3)
      col = rand(1..5)
      @maze[row][col] = Pit.new unless @maze[row][col].is_a?(Pit)
    end
  end

  # Places the wumpus randomly in the game maze
  # @return [void]
  def place_wumpus
    loop do
      row = rand(3)
      col = rand(1..5)
      if @maze[row][col].is_a?(Location)
        @maze[row][col] = Wumpus.new
        @wumpus_row = row
        @wumpus_col = col
        break
      end
    end
  end

  # === Hunt the Wumpus Map Printing Methods ===

  # Prints the maze with the player's position
  # @return [void]
  def print_maze
    @maze.each_with_index do |row, i|
      row.each_with_index do |location, j|
        if i == @player_row && j == @player_col
          print "X"
        else
          print "O"
        end
      end
      puts
    end
  end

  # Prints the final maze to reveal wumpus and pits
  # @return [void]
  def print_final_maze
    @maze.each do |row|
      row.each do |location|
        print location.print
      end
      puts
    end
  end

  # === Hunt the Wumpus Player Move and Input Methods ===

  # Handles player options, moving, and output
  # @return [void]
  def move
    puts "What do you want to do:"
    puts " u) move up"
    puts " d) move down"
    puts " l) move left"
    puts " r) move right"
    puts " s) shoot arrow"
    print "ENTER CHOICE: "
  
    # Gets user input and verifies correct format
    choice = gets.chomp.downcase
    case choice
    when 'u'
      if @player_row > 0
        @player_row -= 1
      else
        puts "You bumped into a wall!"
      end
    when 'd'
      if @player_row < 3
        @player_row += 1
      else
        puts "You bumped into a wall!"
      end
    when 'l'
      if @player_col > 0
        @player_col -= 1
      else
        puts "You bumped into a wall!"
      end
    when 'r'
      if @player_col < 5
        @player_col += 1
      else
        puts "You bumped into a wall!"
      end
    when 's'
      shoot_arrow
    else
      puts "Oops! Try something else..."
    end
  end

  # === Hunt the Wumpus Player Loss Detection and Hint Methods ===

  # Checks the player's current location for game over conditions or hints
  # @return [void]
  def check_location
    if @maze[@player_row][@player_col].is_a?(Pit) || @maze[@player_row][@player_col].is_a?(Wumpus)
      @maze[@player_row][@player_col].visit
      @game_over = true
    else
      print_hints
    end
  end

  # Prints hints based on adjacent pit and wumpus locations
  # @return [void]
  def print_hints
    # Checks valid bounds and evaluates action
    hints = []
    [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dr, dc|
      r, c = @player_row + dr, @player_col + dc
      next if r < 0 || r >= 4 || c < 0 || c >= 6

      unless @game_over
        hints << "You smell a stench." if @maze[r][c].is_a?(Wumpus)
        hints << "You feel a breeze." if @maze[r][c].is_a?(Pit)
      end
    end
    puts hints.uniq.join("\n") unless hints.empty?
  end

  # === Hunt the Wumpus Arrow Shooting Method ===

  # Handles arrow shooting logic for game
  # @return [void]
  def shoot_arrow
    loop do
      puts "What direction do you want to shoot your arrow:"
      puts " u) up"
      puts " d) down"
      puts " l) left"
      puts " r) right"
      print "ENTER CHOICE: "
  
      # Ensures valid direction and input
      direction = gets.chomp.downcase
      dr, dc = case direction
               when 'u' then [-1, 0]
               when 'd' then [1, 0]
               when 'l' then [0, -1]
               when 'r' then [0, 1]
               else
                 puts "That's not a valid direction! The wumpus advises you to try again."
                 next
               end
  
      # Determines game ending from shooting arrow
      r, c = @player_row + dr, @player_col + dc
      if r == @wumpus_row && c == @wumpus_col
        puts "You killed the wumpus! You win the game."
        @game_over = true
      else
        puts "You shot in the wrong direction and became the snack for the wumpus. You lost!"
        @game_over = true
      end
      break
    end
  end
end

# === Hunt the Wumpus Main Method ===

# Create a Game object and starts new game
# @return [void]
game = Game.new
game.play