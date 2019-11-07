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
    @profile = User.find(params[:profile_id]).profile
    # @profile = Profile.find(params[:profile_id])
    exclude_profiles = [@profile.id.to_s] + @profile.accepted_profiles + @profile.rejected_profiles
    profile_select = Profile.where.not(id: exclude_profiles).order('random()').first(5)

    render json: profile_select
  end

  def match_show
    @profile = User.find(params[:profile_id]).profile
    matches = MatchPair.where(profile_id: @profile.id).or(MatchPair.where(match_id: @profile.id))

    render json: matches
  end

  def accept
    @profile = Profile.find(params[:profile_id])
    @profile.accepted_profiles.push(params[:profile])

    p match_id = check_match(params[:profile_id], params[:profile])
    if @profile.save
      render json: {match_id: match_id, status: :updated}
    else
      render json: {status: :unprocessable_entity}
    end
  end

  def reject
    @profile = Profile.find(params[:profile_id])
    @profile.rejected_profiles.push(params[:profile])
    if @profile.save
      render json: {status: :updated}
    else
      render json: {status: :unprocessable_entity}
    end
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.picture_url =  @profile.picture.url
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

  def check_match(current_profile_id, profile_id)

    profile_check = Profile.find(profile_id)
    if profile_check.accepted_profiles.include?(current_profile_id)
      match = MatchPair.find_or_create_by! profile_id: current_profile_id, match_id: profile_id
      match.id
    else
      nil
    end
  end

end