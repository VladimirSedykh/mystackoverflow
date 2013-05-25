class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :tag
	attr_accessible :title, :body, :user_id, :tags_list
end