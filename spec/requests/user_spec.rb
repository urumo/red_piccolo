# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/user/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /login' do
    it 'returns http success' do
      get '/user/login'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /register' do
    it 'returns http success' do
      get '/user/register'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /id' do
    it 'returns http success' do
      get '/user/id'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /block' do
    it 'returns http success' do
      get '/user/block'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /settings' do
    it 'returns http success' do
      get '/user/settings'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /auth' do
    it 'returns http success' do
      get '/user/auth'
      expect(response).to have_http_status(:success)
    end
  end
end
