class Link < ActiveRecord::Base
  attr_accessible :description, :site, :url, :user_id, :comment_count

  belongs_to :user
  has_many :votes
  has_many :comments, :as => :subject

  validate :url_uniqueness

  before_save :add_http, :assign_site

  before_create :set_comment_count


  def link
    self
  end

  private

  def add_http
    if !self.url.include?("http")
      self.url = "http://" + self.url
    end
  end

  def assign_site
    slash_1 = self.url
    self.site = "(#{self.url.split("/")[2]})"
  end

  def url_uniqueness
    add_http

    @link = Link.find_by_url(self.url)

    errors.add(:base, "This link has already been posted") if @link != nil && @link.id != self.id

  end

  def set_comment_count
    self.comment_count = 0
  end

end
