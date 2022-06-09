# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :logged_in_user, except: [:show, :index, :search]

  def index
    @posts = Rails.cache.fetch('posts', expires_in: 1.minutes) { Post.all }
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def search
    @posts = Post.search(params[:search]).records.to_a
    render 'index'
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
