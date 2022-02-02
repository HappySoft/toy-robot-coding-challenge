# frozen_string_literal: true

RSpec.describe Dispatcher do
  let(:robot) { instance_double('Robot') }

  subject(:dispatcher) { Dispatcher.new(robot) }

  describe '#perform' do
    it 'PLACE' do
      expect(robot).to receive(:place).with(1, 2, 'NORTH')
      dispatcher.perform('PLACE 1,2,NORTH')
    end

    it 'MOVE' do
      expect(robot).to receive(:move)
      dispatcher.perform('MOVE')
    end

    it 'LEFT' do
      expect(robot).to receive(:left)
      dispatcher.perform('LEFT')
    end

    it 'RIGHT' do
      expect(robot).to receive(:right)
      dispatcher.perform('RIGHT')
    end

    describe 'REPORT' do
      it 'delegates to Robot object' do
        expect(robot).to receive(:report)
        dispatcher.perform('REPORT')
      end

      it 'prints results to STDOUT' do
        expect(robot).to receive(:report).and_return([1, 2, 'NORTH'])

        expect { dispatcher.perform('REPORT') }.to \
          output("1,2,NORTH\n").to_stdout
      end

      it 'prints nothing when robot was not placed yet' do
        expect(robot).to receive(:report)
        expect { dispatcher.perform('REPORT') }.to_not output.to_stdout
      end
    end
  end
end
