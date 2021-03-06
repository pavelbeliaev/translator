class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # rubocop:disable Lint/UnusedMethodArgument
  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
  # rubocop:enable Lint/UnusedMethodArgument
end
