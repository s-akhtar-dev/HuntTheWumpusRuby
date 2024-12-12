# Ruby: Hunt the Wumpus Game

## Description
The **Hunt the Wumpus** game is a text-based adventure implemented in Ruby. Players navigate through a maze filled with various hazards, including pits and the Wumpus itself. The objective is to explore the maze, avoid dangers, and ultimately slay the Wumpus using arrows.

## Authors
- **Sarah Akhtar**
- **Kieran Monks**

## Date
October 14th, 2024

## Game Features
- **Maze Exploration**: Navigate through a 4x6 maze with various locations.
- **Hazards**: Encounter pits that lead to instant loss and the Wumpus that must be defeated.
- **Player Movement**: Move in four directions (up, down, left, right) or shoot arrows.
- **Hints**: Receive hints about nearby hazards based on your current location.

## Classes Overview
The game consists of several classes that manage different aspects of gameplay:

1. **Location**: Represents a generic location in the maze.
2. **Pit**: Inherits from Location; represents a pit hazard.
3. **Wumpus**: Inherits from Location; represents the Wumpus.
4. **Game**: Contains the main game logic, including initialization, player movement, and loss detection.

## Initialization and Game Loop
The game initializes a maze filled with locations, pits, and a Wumpus. The player starts at a designated position and can move around the maze or shoot arrows to defeat the Wumpus.

### Main Game Loop
```ruby
game = Game.new
game.play
```

### Running the Game
To run this game, ensure you have Ruby installed on your system. Follow these steps to get started:
1. Clone or download the repository containing the game files.
2. Open your terminal or command prompt.
3. Navigate to the directory containing wumpus.rb.
4. Run the command:
   ```bash
    ruby wumpus.rb
   ```
   
### Gameplay Instructions
- Use u, d, l, r to move up, down, left, or right respectively.
- Use s to shoot an arrow in the desired direction.
- Pay attention to hints provided after each move to avoid dangers.
  
### Conclusion
The Hunt the Wumpus game is an engaging text-based adventure that combines exploration and strategy. It serves as an excellent example of object-oriented programming in Ruby while providing players with an entertaining challenge.

Feel free to contribute to this project by submitting issues or pull requests!
