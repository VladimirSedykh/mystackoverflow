class Question < Post
  has_many :answers
  has_many :question_tags
  has_many :tags, :through => :question_tags

  default_scope { where(is_question: true) }

end