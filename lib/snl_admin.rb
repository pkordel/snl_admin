require "snl_admin/engine"

module SnlAdmin
  # This is where global configuration options can go
  mattr_accessor :user_class
  mattr_accessor :redirection_class
  mattr_accessor :license_class
  mattr_accessor :taxonomy_class
  mattr_accessor :revision_class

  def self.user_class
    @@user_class.constantize
  end

  def self.redirection_class
    @@redirection_class.constantize
  end

  def self.license_class
    @@license_class.constantize
  end

  def self.taxonomy_class
    @@taxonomy_class.constantize
  end

  def self.activity_class
    @@revision_class.constantize
  end
end
