class Location
    def print
      "O"
    end
  
    def visit
      puts
    end
  end
  
  class Pit < Location
    def print
      "p"
    end
  
    def visit
      puts "Ahhhh! You fell into a pit..."
    end
  end
  
  class Wumpus < Location
    def print
      "w"
    end
  
    def visit
      puts "Uh oh! You got eaten by the wumpus..."
    end
  end
  
  class Game
    def initialize
      @maze = Array.new(4) { Array.new(6) { Location.new } }
      @player_row = 3
      @player_col = 0
      @game_over = false
      
      place_pits
      place_wumpus
    end
  
    def play
      puts "Hunt down the wumpus and try to shoot it with your arrow!\n\n"
      
      until @game_over
        print_maze
        move
        check_location
        puts
      end
  
      print_final_maze
    end
  
    private
  
    def place_pits
      4.times do
        row = rand(3)
        col = rand(1..5)
        @maze[row][col] = Pit.new unless @maze[row][col].is_a?(Pit)
      end
    end
  
    def place_wumpus
      loop do
        row = rand(3)
        col = rand(1..5)
        if @maze[row][col].is_a?(Location)
          @maze[row][col] = Wumpus.new
          break
        end
      end
    end
  
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
  
    def print_final_maze
      @maze.each do |row|
        row.each do |location|
          print location.print
        end
        puts
      end
    end
  
    def move
      puts "What do you want to do:"
      puts " u) move up"
      puts " d) move down"
      puts " l) move left"
      puts " r) move right"
      puts " s) shoot arrow"
      print "ENTER CHOICE: "
  
      choice = gets.chomp.downcase
      case choice
      when 'u'
        @player_row -= 1 if @player_row > 0
      when 'd'
        @player_row += 1 if @player_row < 3
      when 'l'
        @player_col -= 1 if @player_col > 0
      when 'r'
        @player_col += 1 if @player_col < 5
      when 's'
        shoot_arrow
      else
        puts "Invalid input. Try again."
      end
    end
  
    def check_location
      @maze[@player_row][@player_col].visit
      @game_over = true if @maze[@player_row][@player_col].is_a?(Pit) || @maze[@player_row][@player_col].is_a?(Wumpus)
      
      print_hints
    end
  
    def print_hints
      hints = []
      [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dr, dc|
        r, c = @player_row + dr, @player_col + dc
        next if r < 0 || r >= 4 || c < 0 || c >= 6
  
        hints << "You smell a stench." if @maze[r][c].is_a?(Wumpus)
        hints << "You feel a breeze." if @maze[r][c].is_a?(Pit)
      end
      puts hints.uniq.join("\n") unless hints.empty?
    end
  
    def shoot_arrow
      puts "What direction do you want to shoot your arrow:"
      puts " u) up"
      puts " d) down"
      puts " l) left"
      puts " r) right"
      print "ENTER CHOICE: "
  
      direction = gets.chomp.downcase
      dr, dc = case direction
               when 'u' then [-1, 0]
               when 'd' then [1, 0]
               when 'l' then [0, -1]
               when 'r' then [0, 1]
               else
                 puts "Invalid direction. Try again."
                 return
               end
  
      r, c = @player_row + dr, @player_col + dc
      if r >= 0 && r < 4 && c >= 0 && c < 6 && @maze[r][c].is_a?(Wumpus)
        puts "You killed the wumpus! You win the game."
        @game_over = true
      else
        puts "You shot in the wrong direction and became the snack for the wumpus. You lost!"
        @game_over = true
      end
    end
  end
  
  # Create a Game object and start playing
  game = Game.new
  game.play