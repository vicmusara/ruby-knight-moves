# frozen_string_literal: true

class KnightMoves
  BOARD_SIZE = 8
  MOVES = [
    [2, 1], [1, 2], [-1, 2], [-2, 1],
    [-2, -1], [-1, -2], [1, -2], [2, -1]
  ].freeze

  def initialize(start, goal)
    @start = start
    @goal = goal
  end

  def knight_moves
    path = bfs
    puts "You made it in #{path.length - 1} moves! Here's your path:"
    path.each { |square| p square }
  end

  private

  def bfs
    queue = [[@start]]
    visited = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, false) }
    visited[@start[0]][@start[1]] = true

    until queue.empty?
      path = queue.shift
      current_position = path.last

      return path if current_position == @goal

      possible_moves(current_position).each do |move|
        next if visited[move[0]][move[1]]

        visited[move[0]][move[1]] = true
        new_path = path.dup << move
        queue << new_path
      end
    end
  end

  def possible_moves(position)
    x, y = position
    MOVES.map { |dx, dy| [x + dx, y + dy] }
         .select { |nx, ny| valid_move?(nx, ny) }
  end

  def valid_move?(x, y)
    x.between?(0, BOARD_SIZE - 1) && y.between?(0, BOARD_SIZE - 1)
  end
end

def knight_moves(start, goal)
  KnightMoves.new(start, goal).knight_moves
end

# Example Usage
knight_moves([0, 0], [3, 3])
knight_moves([3, 3], [0, 0])
knight_moves([0, 0], [7, 7])
