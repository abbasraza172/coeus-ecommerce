class ApplicationController < ActionController::Base
    before_action :set_subdomain

   # Returns the first subdomain of the request
   #
   # It looks for the first subdomain domain of the
   # request. If subdomain is found it returns the 
   # first subdomain and if not found it returns nil.
    def set_subdomain
        @sub_domain = request.subdomains.first rescue nil
    end
end
