class Api::V1::ProfilesController < ApplicationController
    before_action :set_profile, only: [:show, :update, :destroy]
    before_action :set_user, only: [:show, :create, :update, :destroy]
    # TODO: Decide how to show profiles to logged in users
    #       Currently all GET /api/v1/profiles/{USER_ID} URLs are public
    before_action :check_owner, only: [:create, :update, :destroy]

    def show
      if @profile
        render json: @profile
      else
        render json: {
        error: "Profile not found (id: #{params[:id]})"
        }, status: 404
      end
    end

    def create
      @profile = Profile.new(profile_params)
      if @profile.save
        render json: @profile, status: :created
      else
        render json: @profile.errors, status: :unprocessable_entity
      end
    end

    def update
      if @profile.update(profile_params)
        render json: @profile, status: :ok
      else
        render json: @profile.errors, status: :unprocessable_entity
      end
    end

    def destroy
        @profile.destroy
        head 204
    end

    private 

    def profile_params
        params.require(:profile).permit(:dog_name, :biography, :user_id, :picture)
    end

    def set_profile
        @profile = Profile.find_by(user_id: params[:id])
    end

    def set_user
      # TODO: Clean this up, it's a bit hacky
      @user = User.find(params[:id] || params[:profile][:user_id])
    end

    def check_owner
      head :forbidden unless @user.id == current_user&.id
    end
end