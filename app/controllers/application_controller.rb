class ApplicationController < ActionController::Base
    before_action :set_subdomain

    def set_subdomain
        @sub_domain = request.subdomains.first rescue nil
    end
end
