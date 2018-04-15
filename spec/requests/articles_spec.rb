require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe 'POST #create' do
    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        post articles_path, params: { article: { title: '', content: '', email: '' }, format: :json }
        expect(response).to have_http_status(400)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        post articles_path, params: { article: { title: 'test title', content: 'test content', email: 'test@crossover.com' }, format: :json }
        expect(response).to have_http_status(201)
      end
    end
  end
end
