class Comment < ActiveRecord::Base
  attr_accessible :body, :subject_id, :subject_type, :user_id, :comment_count

  belongs_to :user
  belongs_to :subject, :polymorphic => true
  has_many :comments, :as => :subject

  delegate :link, :to => :subject

  before_create :set_comment_count, :update_parent_count


  def update_parent_count
    self.subject.update_parent_count if self.subject.class == Comment

    self.subject.comment_count += 1

    self.subject.save
  end

  private

  def set_comment_count
    self.comment_count = 0
  end


end
