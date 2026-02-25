# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy write update_body generate_body]

  def index
    @posts = Post.all
    @posts = @posts.where(status: params[:status]) if params[:status].present?
    @posts = @posts.where(category: params[:category]) if params[:category].present?
    @posts = @posts.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  def write
  end

  def update_body
    if @post.update(body_params)
      redirect_to @post, notice: "Post body was successfully updated."
    else
      render :write, status: :unprocessable_entity
    end
  end

  def generate_body
    body = PostBodyGenerator.new(@post).call
    if body
      render json: { body: body }
    else
      render json: { error: "Failed to generate body" }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    permitted = params.require(:post).permit(
      :title, :skill_level, :hook, :content_summary, :senior_insight,
      :cta, :status, :category
    )
    permitted[:hashtags] = params[:post][:hashtags].to_s.split
    permitted
  end

  def body_params
    params.require(:post).permit(:body)
  end
end
