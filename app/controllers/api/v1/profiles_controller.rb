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

    def profiles_get
       @profile = Profile.find(params[:profile_id])
       exclude_profiles = [@profile.id.to_s] + @profile.accepted_profiles + @profile.rejected_profiles
       profile_select = Profile.where.not(id: exclude_profiles).order('random()').first(5)
      if profile_select != []
        render json: profile_select
      else
        render json: {
            error: "No new profiles, come back later!"
        }, status: 404
      end
    end

    def accept
      @profile = Profile.find(params[:profile_id])
      @profile.accepted_profiles.push(params[:profile])
      if @profile.save
        render json: { status: :updated }
      else
        render json: { status: :unprocessable_entity }
      end
    end

    def reject
      @profile = Profile.find(params[:profile_id])
      @profile.rejected_profiles.push(params[:profile])
      if @profile.save
        render json: { status: :updated }
      else
        render json: { status: :unprocessable_entity }
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