class Answer < Post
  belongs_to :question
  default_scope { where(is_question: false) }
end
