class Comment < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
end
