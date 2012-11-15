class Comment < ActiveRecord::Base
  attr_accessible :body, :subject_id, :subject_type, :user_id

  belongs_to :user
  belongs_to :subject, :polymorphic => true
  has_many :comments, :as => :subject

  delegate :link, :to => :subject
end
