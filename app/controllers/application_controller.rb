class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :assign_user

  def assign_user
    current_user&.update(id: current_user.id)
  end
end
