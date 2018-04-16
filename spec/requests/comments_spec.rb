require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:article) { FactoryBot.create(:article) }

  describe 'POST #create' do
    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        post article_comments_path(article), params: { comment: { title: '', content: '', email: '' }, format: :json }
        expect(response).to have_http_status(400)
      end
    end

    context 'with valid params' do
      it 'returns 201 response' do
        post article_comments_path(article), params: { comment: { title: 'test title', content: 'test content', email: 'test@crossover.com' }, format: :json }
        expect(response).to have_http_status(201)
      end
    end
  end
end
