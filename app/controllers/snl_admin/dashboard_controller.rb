require_dependency "snl_admin/application_controller"

module SnlAdmin
  class DashboardController < ApplicationController
    def index
      @performers = User
        .select([:id, :firstname, :lastname, :num_characters_changed])
        .order('num_characters_changed desc')
        .limit(5)
    end
  end
end
