require 'rails_helper'

describe Instructor do
  context 'validation' do
    it 'attributes cannot be blank' do
      new_instructor = Instructor.new

      new_instructor.valid?

      expect(new_instructor.errors[:name]).to include('não pode ficar em branco')
      expect(new_instructor.errors[:email]).to include('não pode ficar em branco')
    end
  end
end
