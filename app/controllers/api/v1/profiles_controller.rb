class Api::V1::ProfilesController < ApplicationController

    def show
      @profile = set_profile
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
      @profile = set_profile
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

end