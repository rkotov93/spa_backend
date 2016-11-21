# frozen_string_literal: true
module Api
  module V1
    class PostsController < ApplicationController
      def index
        posts = Post.includes(:user).page(params[:page] || 1)
        render json: posts
      end

      def show
        post = Post.find(params[:id])
        render json: post
      end

      def create
        post = current_user.posts.create(post_params)
        render json: post
      end

      def update
        post = Post.find(params[:id])
        post.update_attributes(post_params)
        render json: post
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy
        render json: post
      end

      private

      def post_params
        params.require(:post).permit(:title, :body)
      end
    end
  end
end
