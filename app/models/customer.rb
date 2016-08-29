class Customer < ActiveRecord::Base
  has_many :tasks

  belongs_to :officer, foreign_key: :officer_id, class_name: 'User'
  belongs_to :leader, foreign_key: :leader_id, class_name: 'User'
  belongs_to :manager, foreign_key: :manager_id, class_name: 'User'
end
