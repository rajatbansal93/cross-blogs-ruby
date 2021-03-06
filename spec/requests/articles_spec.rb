require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe 'POST #create' do
    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        post articles_path, params: { article: { title: '', content: '', email: '' }, format: :json }
        expect(response).to have_http_status(400)
      end
    end

    context 'with valid params' do
      it 'returns 201 response' do
        post articles_path, params: { article: { title: 'test title', content: 'test content', email: 'test@crossover.com' }, format: :json }
        expect(response).to have_http_status(201)
      end

      it 'returns object json' do
        post articles_path, params: { article: { title: 'test title', content: 'test content', email: 'test@crossover.com' }, format: :json }
        expect(JSON.parse(response.body)['title']).to eq('test title')
        expect(JSON.parse(response.body)['content']).to eq('test content')
        expect(JSON.parse(response.body)['email']).to eq('test@crossover.com')
      end
    end
  end

  describe 'PATCH #update' do
    let(:article) { FactoryBot.create(:article) }

    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        patch article_path(article), params: { article: { title: '', content: '', email: '' }, format: :json }
        expect(response).to have_http_status(400)
      end
    end

    context 'with valid params' do
      it 'returns 200 response' do
        patch article_path(article), params: { article: { published: false }, format: :json }
        expect(response).to have_http_status(200)
      end

      it 'returns object json' do
        patch article_path(article), params: { article: { published: false }, format: :json }
        expect(JSON.parse(response.body)['published']).to eq(false)
      end
    end
  end

  describe 'DEL #destroy' do
    let(:article) { FactoryBot.create(:article) }

    context 'with valid params' do
      it 'returns 200 response' do
        delete article_path(article), params: { format: :json }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET #search' do
    let!(:articles) { FactoryBot.create_list(:article, 5) }
    let!(:article) { FactoryBot.create(:article, title: "some keyword") }

    context 'with valid params' do
      it 'returns 200 response' do
        get search_articles_path, params: { format: :json, keyword: "test" }
        expect(response).to have_http_status(200)
      end

      it 'returns matching object' do
        get search_articles_path, params: { format: :json, keyword: "keyword" }
        expect(JSON.parse(response.body)['articles'].count).to be(1)
        expect(JSON.parse(response.body)['articles'].first['title']).to eq('some keyword')
      end
    end
  end
end
