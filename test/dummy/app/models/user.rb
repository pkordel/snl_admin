class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  ROLES = %w(editor authoritative_editor sub_editor contributor bughunter)

  EDITOR        = 'editor'
  CONTRIBUTOR   = 'contributor'

  validates_presence_of :firstname, :lastname, :email_address

  def public_name
    (self.firstname.to_s + ' ' + self.lastname).strip
  end
end
