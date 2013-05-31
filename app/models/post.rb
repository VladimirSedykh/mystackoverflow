class Post < ActiveRecord::Base
	belongs_to :user
  has_many :answers
	attr_accessible :title, :body, :user_id, :tagslist, :view

	validates :title, :presence => true,
                    :length => { :minimum => 5 }

	# AVAILAVLE_TAB_METHODS = %w(my today week month)
	# def self.by_tab(method)
	# method = "all" unless AVAILAVLE_TAB_METHODS.include? method
	# 	Post.send method
	# end

	scope :my, lambda { |user| where(user_id: user.id) }

  def self.today
  	Post.find(:all, :conditions => {:created_at => 1.day.ago..Time.now})
  end

  def self.week
  	Post.find(:all, :conditions => {:created_at => 1.week.ago..Time.now})
  end

  def self.month
  	Post.find(:all, :conditions => {:created_at => 1.month.ago..Time.now})
  end

  def self.frequent
    Post.find(:all, :order => "view desc", :limit => 10)  
  end

  def self.counter(id)
    p = Post.find(id)
    p.view + 1
  end

end