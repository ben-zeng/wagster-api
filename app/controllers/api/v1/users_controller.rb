class Api::V1::UsersController < ApplicationController
  def show
    render json: User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render kson: @user, status: :ok
    else
      render kson: @user.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @user.destroy
    head 204
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
