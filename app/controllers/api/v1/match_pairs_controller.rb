class Api::V1::MatchPairController < ApplicationController
  # controller may not be needed
  def show

  end

  def create

  end

  def update

  end

  def destroy

  end

  private

  # def match_pair_params
  #   params.require(:match_pair).permit(:profile_id, :match_id)
  # end


  def set_match_pair
    @profile = Profile.find(params[:match_pair_id])
  end

end