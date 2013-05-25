module SnlAdmin
  class UserPresenter < SimpleDelegator
    attr_reader :user

    def initialize(user)
      super(user)
      @user = user
    end

    def public_name
      ("#{user.firstname} #{user.lastname}").strip
    end

    # self.num_characters_changed = 0
    # self.num_new_articles       = 0
    # self.num_changed_articles   = 0
    # self.num_new_authorized     = 0
    # self.num_changed_authorized = 0

    def characters_changed
      @user.num_characters_changed
    end
  end
end
