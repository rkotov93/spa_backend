# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:author) { create :user }
  let(:user) { create :user }
  let!(:first_post) { create :post, user: author }

  describe 'GET /posts' do
    context 'without pagination' do
      before { get api_v1_posts_path }

      it 'returns list of posts' do
        expect(response).to have_http_status(200)
        expect(response.body).to eq [PostSerializer.new(first_post)].to_json
      end
    end

    context 'with pagination' do
      let!(:another_post) { create :post, user: author, created_at: DateTime.current - 1.day }

      before do
        Post.per_page = 1
        get api_v1_posts_path(page: 2)
      end

      it 'returns list of posts on second page' do
        expect(response).to have_http_status(200)
        expect(response.body).to eq [PostSerializer.new(another_post)].to_json
      end
    end
  end

  describe 'GET /post/:id' do
    before { get api_v1_post_path(first_post) }

    it 'returns requested post' do
      expect(response).to have_http_status(200)
      expect(response.body).to eq PostSerializer.new(first_post).to_json
    end
  end

  describe 'POST /posts' do
    let!(:posts_count) { Post.count }
    let(:new_post) { build :post }

    context 'with valid params' do
      before do
        post_params = { title: new_post.title, body: new_post.body }
        post api_v1_posts_path, headers: { authorization: jwt_for(author) }, params: { post: post_params }
      end

      it 'creates and returns new post' do
        expect(Post.count).to eq posts_count + 1
        expect(response).to have_http_status(200)
        expect(response.body).to eq PostSerializer.new(Post.last).to_json
      end
    end

    context 'with invalid params' do
      let(:post_params) { { title: 'a' * 121, body: new_post.body } }

      before { post api_v1_posts_path, headers: { authorization: jwt_for(author) }, params: { post: post_params } }

      it 'returns post with validation errors' do
        expect(Post.count).to eq posts_count
        expect(response).to have_http_status(406)
        invalid_post = Post.new(post_params.merge(user: author))
        invalid_post.valid?
        expect(response.body).to eq PostSerializer.new(invalid_post).to_json
      end
    end
  end

  describe 'PATCH /posts/:id' do
    context 'by authorized user' do
      context 'with valid params' do
        before do
          patch api_v1_post_path(first_post), headers: { authorization: jwt_for(author) },
                                              params: { post: { title: 'New title' } }
        end

        it 'updates post title' do
          expect(response).to have_http_status(200)
          expect(first_post.reload.title).to eq 'New title'
        end
      end

      context 'with invalid params' do
        before do
          patch api_v1_post_path(first_post), headers: { authorization: jwt_for(author) },
                                              params: { post: { title: 'a' * 121 } }
        end

        it 'does not updates post title' do
          expect(response).to have_http_status(406)
          expect(first_post.reload.title).to eq first_post.title
        end
      end
    end

    context 'by non-authorized user' do
      before do
        patch api_v1_post_path(first_post), headers: { authorization: jwt_for(user) },
                                            params: { post: { title: 'New title' } }
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(401)
        expect(first_post.reload.title).to eq first_post.title
      end
    end
  end

  describe 'DELETE /posts/:id' do
    let!(:posts_count) { Post.count }

    context 'by authorized user' do
      before { delete api_v1_post_path(first_post), headers: { authorization: jwt_for(author) } }

      it 'destroys post' do
        expect(response).to have_http_status(200)
        expect(Post.count).to eq posts_count - 1
      end
    end

    context 'by non-authorized user' do
      before { delete api_v1_post_path(first_post), headers: { authorization: jwt_for(user) } }

      it 'returns unauthorized status' do
        expect(response).to have_http_status(401)
        expect(Post.count).to eq posts_count
      end
    end
  end
end
