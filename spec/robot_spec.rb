# frozen_string_literal: true

RSpec.describe Robot do
  let(:max_x) { 5 }
  let(:max_y) { 4 }
  let(:table) { Table.new(max_x, max_y) }

  subject(:robot) { Robot.new(table) }

  describe '#place' do
    it 'stores coordinates and direction of the robot placement' do
      robot.place(1, 2, 'NORTH')

      expect(robot.position_x).to eq 1
      expect(robot.position_y).to eq 2
      expect(robot.direction).to eq 'NORTH'
    end

    it 'does not store inaccessible coordinates' do
      robot.place(1, 20, 'NORTH')

      expect(robot.position_x).to be_nil
      expect(robot.position_y).to be_nil
    end

    it 'does not remember previous valid coordinates after setting new invalid ones' do
      robot.place(1, 2, 'NORTH')
      robot.place(1, 20, 'NORTH')

      expect(robot.position_x).to be_nil
      expect(robot.position_y).to be_nil
      expect(robot.direction).to be_nil
    end
  end

  describe '#report' do
    it 'returns current coordinates and direction of the robot' do
      robot.place(1, 2, 'NORTH')
      expect(robot.report).to eq [1, 2, 'NORTH']
    end

    it 'returns no coordinates when robot was not placed' do
      expect(robot.report).to be_empty
    end
  end

  describe '#left' do
    it 'changes direction from North to West' do
      robot.place(0, 0, 'NORTH')
      robot.left
      expect(robot.direction).to eq 'WEST'
    end

    it 'changes direction from West to South' do
      robot.place(0, 0, 'WEST')
      robot.left
      expect(robot.direction).to eq 'SOUTH'
    end

    it 'changes direction from South to East' do
      robot.place(0, 0, 'SOUTH')
      robot.left
      expect(robot.direction).to eq 'EAST'
    end

    it 'changes direction from East to North' do
      robot.place(0, 0, 'EAST')
      robot.left
      expect(robot.direction).to eq 'NORTH'
    end
  end

  describe '#right' do
    it 'changes direction from North to East' do
      robot.place(0, 0, 'NORTH')
      robot.right
      expect(robot.direction).to eq 'EAST'
    end

    it 'changes direction from East to South' do
      robot.place(0, 0, 'EAST')
      robot.right
      expect(robot.direction).to eq 'SOUTH'
    end

    it 'changes direction from South to West' do
      robot.place(0, 0, 'SOUTH')
      robot.right
      expect(robot.direction).to eq 'WEST'
    end

    it 'changes direction from West to North' do
      robot.place(0, 0, 'WEST')
      robot.right
      expect(robot.direction).to eq 'NORTH'
    end
  end

  describe '#move' do
    it 'increases position Y when moves North' do
      robot.place(1, 1, 'NORTH')
      robot.move
      expect(robot.position_y).to eq 2
    end

    it 'decreases position Y when moves South' do
      robot.place(1, 1, 'SOUTH')
      robot.move
      expect(robot.position_y).to eq 0
    end

    it 'increases position X when moves East' do
      robot.place(1, 1, 'EAST')
      robot.move
      expect(robot.position_x).to eq 2
    end

    it 'decreases position X when moves West' do
      robot.place(1, 1, 'WEST')
      robot.move
      expect(robot.position_x).to eq 0
    end

    describe 'does not move to inaccessible destination' do
      example do
        robot.place(0, 0, 'WEST')
        robot.move
        expect(robot.position_x).to eq 0
      end

      example do
        robot.place(max_x, 0, 'EAST')
        robot.move
        expect(robot.position_x).to eq max_x
      end

      example do
        robot.place(0, 0, 'SOUTH')
        robot.move
        expect(robot.position_y).to eq 0
      end

      example do
        robot.place(0, max_y, 'NORTH')
        robot.move
        expect(robot.position_y).to eq max_y
      end
    end
  end
end
