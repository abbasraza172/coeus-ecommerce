class ApplicationController < ActionController::Base
    before_action :set_subdomain
    before_action :configure_permitted_parameters, if: :devise_controller?


    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :email, :password, :business_name, :business_description,:password_confirmation])
        # devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    end

   # Returns the first subdomain of the request
   #
   # It looks for the first subdomain domain of the
   # request. If subdomain is found it returns the 
   # first subdomain and if not found it returns nil.
    def set_subdomain
        @sub_domain = request.subdomains.first rescue nil
    end

    def validate_domain
        unless (@sub_domain == "buyer" && current_user.customer?) || (@sub_domain == "seller" && current_user.seller?) || (@sub_domain == "admin" && current_user.admin?)
            redirect_to root_path
        end    
    end
end
