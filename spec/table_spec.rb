# frozen_string_literal: true

RSpec.describe Table do
  let(:max_x) { 5 }
  let(:max_y) { 4 }

  subject(:table) { Table.new(max_x, max_y) }

  it 'is accessible within a table perimeter' do
    expect(table.accessible?(0, 0)).to be true
    expect(table.accessible?(max_x, max_y)).to be true
  end

  it 'is not accessible beyond the west side' do
    expect(table.accessible?(-1, 0)).to be false
  end

  it 'is not accessible beyond the south side' do
    expect(table.accessible?(0, -1)).to be false
  end

  it 'is not accessible beyond the north side' do
    expect(table.accessible?(0, max_y + 1)).to be false
  end

  it 'is not accessible beyond the east side' do
    expect(table.accessible?(0, max_x + 1)).to be false
  end
end
