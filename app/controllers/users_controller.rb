class UsersController < ApplicationController
  before_filter :check_whether_standalone
  before_filter :require_auth

  layout false

  def preferences
  end

  def update
    current_user.update_attributes!(user_params)

    render json: current_user.preferences
  end

  private

  def user_params
    params.require(:user)
      .permit(preferences: [Preference.whole_preference_names])
  end
end
