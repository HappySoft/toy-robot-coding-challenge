# frozen_string_literal: true

# Represents table/map for a robot to roam on.
# Responsible for checking locations accessibility with particular coordinates.
class Table
  # @param max_x [Integer] coordinate of the East corner
  # @param max_y [Integer] coordinate of the North corner
  def initialize(max_x, max_y)
    @max_x = max_x
    @max_y = max_y
  end

  # Checks if location with coordinates x, y is accessible
  # @param x [Integer] horizontal coordinate (West - East), where 0 is at the West corner
  # @param y [Integer] vertical coordinate (South - North), where 0 is at the South corner
  def accessible?(x, y)
    (0..@max_x).include?(x) && (0..@max_y).include?(y)
  end
end
