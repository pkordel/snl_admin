class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  ROLES = %w(editor authoritative_editor sub_editor contributor bughunter)

  EDITOR        = 'editor'
  CONTRIBUTOR   = 'contributor'

  def public_name
    (self.firstname.to_s + ' ' + self.lastname).strip
  end
end
