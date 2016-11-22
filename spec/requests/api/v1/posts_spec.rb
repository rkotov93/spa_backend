require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create :user }
  let!(:one_post) { create :post, user: user }

  describe 'GET /posts' do
    before { get api_v1_posts_path }

    it 'returns list of posts' do
      expect(response).to have_http_status(200)
      expect(response.body).to eq [PostSerializer.new(one_post)].to_json
    end
  end

  describe 'GET /post/:id' do
    before { get api_v1_post_path(one_post) }

    it 'returns requested post' do
      expect(response).to have_http_status(200)
      expect(response.body).to eq PostSerializer.new(one_post).to_json
    end
  end

  describe 'POST /posts' do
    let!(:posts_count) { Post.count }
    let(:new_post) { build :post }

    before do
      post_params = { title: new_post.title, body: new_post.body }
      post api_v1_posts_path, params: { post: post_params }
    end

    it 'creates and returns new post' do
      expect(Post.count).to eq posts_count + 1
      expect(response).to have_http_status(200)
      expect(response.body).to eq PostSerializer.new(Post.last).to_json
    end
  end

  describe 'PATCH /posts/:id' do
    before { patch api_v1_post_path(one_post), params: { post: { title: 'New title' } } }

    it 'updates post title' do
      expect(response).to have_http_status(200)
      expect(one_post.reload.title).to eq 'New title'
    end
  end

  describe 'DELETE /posts/:id' do
    let!(:posts_count) { Post.count }

    before { delete api_v1_post_path(one_post) }

    it 'updates post title' do
      expect(response).to have_http_status(200)
      expect(Post.count).to eq posts_count - 1
    end
  end
end
