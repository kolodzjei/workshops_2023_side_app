# frozen_string_literal: true

class Log < ApplicationRecord
  include ActiveModel::Serializers::JSON

  scope :for_user_id, ->(user_id) { where(user_id: user_id) }
  
  validates :user_id, presence: true
  validates :data, presence: true
end
