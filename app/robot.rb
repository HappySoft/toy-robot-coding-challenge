# frozen_string_literal: true

# Represents a toy robot.
# Responsible for robot movement on a Table object
class Robot
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

  X_INCREMENTS = {
    'WEST' => -1,
    'EAST' => 1
  }.freeze

  Y_INCREMENTS = {
    'NORTH' => 1,
    'SOUTH' => -1
  }.freeze

  attr_reader :position_x, :position_y, :direction

  # @param table [Table] the table object for the robot
  def initialize(table)
    @table = table
  end

  # Resets robot position on the table
  # @param x [Integer] horizontal coordinate (West - East) of the table
  # @param y [Integer] vertical coordinate (South - North) of the table
  # @param f [String] face direction: N, E, S, W
  def place(x, y, f)
    if @table.accessible?(x, y)
      @position_x = x
      @position_y = y
      @direction  = f
    else
      @position_x, @position_y, @direction = nil
    end
  end

  # @return [Array] current robot position/direction or empty list if it wasn't placed
  def report
    [position_x, position_y, direction].compact
  end

  # Rotates the robot 90 degrees counter-clockwise
  def left
    @direction = previous_element(direction, DIRECTIONS)
  end

  # Rotates the robot 90 degrees clockwise
  def right
    @direction = previous_element(direction, DIRECTIONS.reverse)
  end

  # Moves the robot 1 step forward in the current direction.
  # Position won't change if the destination location is not accessible.
  def move
    dest_position_x = position_x + X_INCREMENTS.fetch(direction, 0)
    dest_position_y = position_y + Y_INCREMENTS.fetch(direction, 0)

    return unless @table.accessible?(dest_position_x, dest_position_y)

    @position_x = dest_position_x
    @position_y = dest_position_y
  end

  private

  # Interprets items list as a ring and returns previous element
  def previous_element(el, items)
    el_index = items.index(el)
    items[el_index - 1] if el_index
  end
end
