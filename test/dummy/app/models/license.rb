class License < ActiveRecord::Base
  has_many :users, class_name: SnlAdmin.user_class.to_s
end
