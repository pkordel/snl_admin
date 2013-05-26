require "snl_admin/engine"

module SnlAdmin
  # This is where global configuration options can go
  mattr_accessor :user_class

  def self.user_class
    @@user_class.constantize
  end
end
