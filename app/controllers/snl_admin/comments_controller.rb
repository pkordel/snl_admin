# -*- encoding : utf-8 -*-

require_dependency "snl_admin/application_controller"

module SnlAdmin
  class CommentsController < ApplicationController
    def index
      @comments = SnlAdmin.comment_class.order('created_at desc').page params[:page]
    end
  end
end
