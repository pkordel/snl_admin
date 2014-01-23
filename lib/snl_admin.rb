require "snl_admin/engine"

module SnlAdmin
  # This is where global configuration options can go
  mattr_accessor :user_class
  mattr_accessor :redirection_class

  def self.user_class
    @@user_class.constantize
  end

  def self.redirection_class
    @@redirection_class.constantize
  end
end
