class User < ActiveRecord::Base
  belongs_to :license, class_name: SnlAdmin.license_class.to_s

  ROLES = %w(editor authoritative_editor sub_editor contributor bughunter)
  def public_name
    (self.firstname.to_s + ' ' + self.lastname).strip
  end
  def confirmed?
    !!confirmed_at
  end
end
