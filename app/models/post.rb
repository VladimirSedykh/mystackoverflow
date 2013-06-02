class Post < ActiveRecord::Base
	belongs_to :user
	attr_accessible :title, :body, :user_id, :view, :is_question

  #validates :is_question, :presence => true
	validates :title, :presence => true,
                    :length => { :minimum => 5 }

	# AVAILAVLE_TAB_METHODS = %w(my today week month)
	# def self.by_tab(method)
	# method = "all" unless AVAILAVLE_TAB_METHODS.include? method
	# 	Post.send method
	# end

	scope :my, lambda { |user| where(user_id: user.id) }
  scope :today, lambda { where(created_at: 1.day.ago..Time.now) }
  scope :week, lambda { where(created_at: 1.week.ago..Time.now) }
  scope :month, lambda { where(created_at: 1.month.ago..Time.now) }

  def self.frequent
    Post.find(:all, :order => "view desc", :limit => 10)  
  end

  def self.counter(id)
    p = Post.find(id)
    p.view + 1
  end

end