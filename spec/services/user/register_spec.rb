# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::User::RegisterService do
  setup do
    @correct_email = 'test_e@mail.com'
    @correct_password = 'P@ssw0rd'
    @incorrect_email = 'not_an_email'
    @incorrect_password = '123456'
  end
  describe '#call' do
    context 'with valid params' do
      it 'creates a user' do
        expect do
          described_class.call(@correct_email, @correct_password)
        end.to change { User.count }.by(1)
      end

      it 'throws an error on duplicate email' do
        described_class.call(@correct_email, @correct_password)
        expect do
          described_class.call(@correct_email, @correct_password)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with invalid params' do
      it 'raises an error on invalid email' do
        expect do
          described_class.call(@incorrect_email, @incorrect_password)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'raises an error on invalid password' do
        expect do
          described_class.call(@correct_email, @incorrect_password)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
