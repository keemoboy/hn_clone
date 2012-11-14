class Vote < ActiveRecord::Base
  attr_accessible :link_id, :user_id
  
  belongs_to :link
  belongs_to :user
  
  before_save :check_self_voting, :check_duplicity
  
  private
  
  def check_self_voting    
    errors.add(:base, "You cannot up vote your own link") if self.link.user_id == self.user_id
  end
  
  def check_duplicity
    link = self.link
    link.votes.each do |vote|
      errors.add(:base, "You cannot vote twice on the same link") if vote.user_id == self.user_id
    end
  end
end
