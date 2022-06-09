# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    create_answer(@post)

    redirect_to post_path(@post)
  end

  def answer
    @post = Post.find(params[:post_id])
    @answer = Answer.find(params[:id])
    create_answer(@answer)

    redirect_to post_path(@post)
  end

  def vote
    @post = Post.find(params[:post_id])

    @answer = Answer.find(params[:id])
    current_votes = @answer.votes
    @answer.update(votes: current_votes + 1)

    redirect_to post_path(@post)
  end

  def devote
    @post = Post.find(params[:post_id])

    @answer = Answer.find(params[:id])
    current_votes = @answer.votes
    @answer.update(votes: current_votes - 1)

    redirect_to post_path(@post)
  end

  private

  def answer_params
    params.require(:answer).permit(:description)
  end

  def create_answer(parent)
    Answer.create(answer_params.merge(user_id: current_user.id, answerable: parent))
  end
end
