require_dependency "snl_admin/application_controller"

module SnlAdmin
  class DashboardController < ApplicationController
    def index
      @performers = User
        .select([:id, :firstname, :lastname, :num_characters_changed, :role])
        .order('num_characters_changed desc')
        .limit(5)
      @earners = User
        .where("role = ? OR role = ? OR role = ?",
          'authoritative_editor', 'sub_editor', 'bughunter')
        .select([:id, :firstname, :lastname, :num_characters_changed, :role, :fixed_ceiling])
        .order('num_characters_changed desc')
        .limit(5)
    end
  end
end
