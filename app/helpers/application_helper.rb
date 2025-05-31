module ApplicationHelper
    def active_section
      return :game if controller_name == "games" || controller_name == "levels" || controller_name == "blinds" || controller_name == "home"
      return :league if controller_name == "leagues"
      return :player if controller_name == "players"
  
      # Fallback
      :default
    end
  end