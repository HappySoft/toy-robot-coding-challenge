# frozen_string_literal: true

# Parses textual commands and invokes corresponding Robot methods
class Dispatcher
  # @param robot [Robot] a Robot object that will receive commands
  def initialize(robot)
    @robot = robot
  end

  # @param command [String] textual command: PLACE, MOVE, LEFT, RIGHT, REPORT
  def perform(command)
    case command
    when /\APLACE /
      x, y, f = command.delete_prefix('PLACE ').split(',')
      @robot.place(x.to_i, y.to_i, f)
    when 'MOVE', 'LEFT', 'RIGHT'
      @robot.public_send(command.downcase)
    when 'REPORT'
      position = @robot.report
      puts position.join(',') if position
    end
  end
end
