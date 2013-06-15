class Tag < ActiveRecord::Base
	has_many :posts
	has_many :question_tags
	has_many :questions, :through => :question_tags

	attr_accessible :name, :about, :related_tags, :questions_tagged

	scope :by_name, lambda { |q| where("name LIKE ? OR about LIKE ?", "%#{q}%", "%#{q}%") }

end