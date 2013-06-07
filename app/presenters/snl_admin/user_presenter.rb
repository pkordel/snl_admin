module SnlAdmin
  class UserPresenter < SimpleDelegator
    attr_reader :user
    include ActionView::Helpers::NumberHelper

    def initialize(user)
      super(user)
      @user = user
    end

    def public_name
      ("#{user.firstname} #{user.lastname}").strip
    end

    def role_name
      I18n.t(user.role.to_s).humanize
    end
  end
end
