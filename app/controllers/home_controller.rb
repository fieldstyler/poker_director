class HomeController < ApplicationController
    before_action :set_active_section

    def index
    end

    private

    def set_active_section
        @active_section = :game
    end 
end
