# frozen_string_literal: true
module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user, only: [:create, :update, :destroy]

      def index
        posts = Post.includes(:user).order(created_at: :desc).page(params[:page] || 1)
        render json: posts
      end

      def show
        post = Post.find(params[:id])
        render json: post
      end

      def create
        post = current_user.posts.build(post_params)
        status = post.save ? :ok : :not_acceptable
        render json: post, status: status
      end

      def update
        post = Post.find(params[:id])
        status = post.update_attributes(post_params) ? :ok : :not_acceptable
        render json: post, status: status
      end

      def destroy
        post = Post.find(params[:id])
        status = post.destroy ? :ok : :not_acceptable
        render json: post, status: status
      end

      private

      def post_params
        params.require(:post).permit(:title, :body)
      end
    end
  end
end
