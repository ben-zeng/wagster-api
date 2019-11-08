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
    current_user_id = params[:profile_id]

    @profile = User.find(current_user_id).profile

    exclude_profiles = [@profile.id.to_s] + @profile.accepted_profiles + @profile.rejected_profiles
    profile_select = Profile.where.not(id: exclude_profiles).order('random()').first(5)

    render json: profile_select
  end

  def match_show
    current_user_id = params[:profile_id]

    @profile = User.find(current_user_id).profile
    match_pairs = MatchPair.where(profile_id: @profile.id).or(MatchPair.where(match_id: @profile.id))

    match_details = match_pairs.map do |match|
      if match.profile_id != @profile.id
        other_profile_id = match.profile_id
      else
        other_profile_id = match.match_id
      end

      user_id = Profile.find(other_profile_id).user_id
      email = User.find(user_id).email

      {
        profile_id: other_profile_id,
        user_id: user_id,
        email: email
      }
    end

    render json: match_details
  end

  def accept
    current_user_id = params[:profile_id]
    accepted_profile_id = params[:profile]

    @profile = User.find(current_user_id).profile
    current_profile_id = @profile.id

    p "DEBUG: accept: current_user_id=#{current_user_id}, current_profile_id=#{current_profile_id}, accepted_profile_id=#{accepted_profile_id}"

    @profile.accepted_profiles.push(accepted_profile_id)

    match_id = check_match(current_profile_id, accepted_profile_id)

    p "DEBUG: accept: match_id=#{match_id}"

    if @profile.save
      p "DEBUG: accept: profile #{@profile.id} saved"
      render json: {match_id: match_id, status: :updated}
    else
      render json: {status: :unprocessable_entity}
    end
  end

  def reject
    current_user_id = params[:profile_id]
    other_profile_id = params[:profile]

    @profile = User.find(current_user_id).profile

    @profile.rejected_profiles.push(other_profile_id)

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
      render json: {error: "Profile already created!"}, status: :unprocessable_entity
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
    user_id = params[:id]
    @profile = Profile.find_by(user_id: user_id)
  end

  def check_match(current_profile_id, accepted_profile_id)
    current_profile_id = current_profile_id.to_s

    p "DEBUG: check_match: current_profile_id=#{current_profile_id}, accepted_profile_id=#{accepted_profile_id}"

    accepted_profile = Profile.find(accepted_profile_id)

    accepted_profiles = accepted_profile.accepted_profiles

    p "DEBUG: check_match: accepted_profiles=#{accepted_profiles} for profile #{accepted_profile_id}"
    p "DEBUG: current_profile_id is a string? #{current_profile_id.is_a?(String)}"

    # accepted_profiles is an array of strings, so current_profile_id must be a string
    if accepted_profiles.include?(current_profile_id)
      match = MatchPair.find_or_create_by! profile_id: current_profile_id, match_id: accepted_profile_id

      p "DEBUG: check_match: match=#{match}"

      match.id
    else
      nil
    end
  end

end