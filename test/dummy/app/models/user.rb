class User < ActiveRecord::Base
  ROLES = %w(editor authoritative_editor sub_editor contributor bughunter)
  def public_name
    (self.firstname.to_s + ' ' + self.lastname).strip
  end
end
