# frozen_string_literal: true

RSpec.describe Dispatcher do
  subject(:dispatcher) { described_class.new(robot) }

  let(:robot) { instance_spy('Robot') }

  describe '#perform' do
    it 'PLACE' do
      dispatcher.perform('PLACE 1,2,NORTH')
      expect(robot).to have_received(:place).with(1, 2, 'NORTH')
    end

    it 'MOVE' do
      dispatcher.perform('MOVE')
      expect(robot).to have_received(:move)
    end

    it 'LEFT' do
      dispatcher.perform('LEFT')
      expect(robot).to have_received(:left)
    end

    it 'RIGHT' do
      dispatcher.perform('RIGHT')
      expect(robot).to have_received(:right)
    end

    describe 'REPORT' do
      before do
        allow(robot).to receive(:report).and_return(nil)
      end

      it 'delegates to Robot object' do
        dispatcher.perform('REPORT')
        expect(robot).to have_received(:report)
      end

      it 'prints nothing when robot was not placed yet' do
        expect { dispatcher.perform('REPORT') }.not_to output.to_stdout
        expect(robot).to have_received(:report)
      end

      it 'prints results to STDOUT' do
        allow(robot).to receive(:report).and_return([1, 2, 'NORTH'])

        expect { dispatcher.perform('REPORT') }.to \
          output("1,2,NORTH\n").to_stdout
      end
    end
  end
end
