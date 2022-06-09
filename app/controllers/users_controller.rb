# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if user_params[:password] == user_params[:password_confirmation] && @user.save
      log_in @user
      flash[:success] = 'Welcome to the app!'
      redirect_to root_path
    else
      @user.errors.add(:base, 'Both the passwords should be same.') if user_params[:password] != user_params[:password_confirmation]
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
