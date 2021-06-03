class HomeController < ApplicationController
    layout 'default_layout'
    
    def index
    end

    def main
        if @sub_domain == "buyer"
            redirect_to index_path
        else
            redirect_to home_next_path
        end   
    end

    def next     
    end
end
