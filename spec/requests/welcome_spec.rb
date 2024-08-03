require 'rails_helper'

RSpec.describe 'Welcomes', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end


    it 'includes the welcome message' do
      get '/'
      expect(response.body).to include('Welcome to our site!')
    end
  end
end