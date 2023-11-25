class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      case resource
        when Admin
          admin_path
        when Customer
          root_path
      end
    end

  def after_sign_out_path_for(admin)
    new_admin_session_path
  end
end
