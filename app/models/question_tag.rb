class QuestionTag < ActiveRecord::Base
  attr_accessible :question, :tag
  belongs_to :question
  belongs_to :tag
end