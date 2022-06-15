# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :find_post

  def create
    create_answer(@post)

    redirect_to post_path(@post)
  end

  def answer
    @answer = Answer.find(params[:id])
    create_answer(@answer)

    redirect_to post_path(@post)
  end

  def vote
    @answer = Answer.find(params[:id])
    current_votes = @answer.votes
    @answer.update(votes: current_votes + 1)

    redirect_to post_path(@post)
  end

  def devote
    @answer = Answer.find(params[:id])
    current_votes = @answer.votes
    @answer.update(votes: current_votes - 1)

    redirect_to post_path(@post)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def answer_params
    params.require(:answer).permit(:description)
  end

  def create_answer(parent)
    Answer.create(answer_params.merge(user_id: current_user.id, answerable: parent))
  end
end
