module SnlAdmin
  class UserPresenter < SimpleDelegator
    attr_reader :user, :template

    def initialize(user, template)
      super(user)
      @template = template
      @user     = user
    end

    def public_name
      ("#{user.firstname} #{user.lastname}").strip
    end

    def role_name
      I18n.t(user.role.to_s).humanize
    end
  end
end
