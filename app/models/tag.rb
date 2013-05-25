class Tag < ActiveRecord::Base
	has_many :posts
	attr_accessible :name, :about, :related_tags, :questions_tagged 
end