class ApplicationController < ActionController::Base
    before_action :set_subdomain
    before_action :configure_permitted_parameters, if: :devise_controller?


    def configure_permitted_parameters
        # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :email, :password, :business_name, :business_description,:password_confirmation])
    end

   # Returns the first subdomain of the request
   #
   # It looks for the first subdomain domain of the
   # request. If subdomain is found it returns the 
   # first subdomain and if not found it returns nil.
    def set_subdomain
        @sub_domain = request.subdomains.first rescue nil
    end
end
