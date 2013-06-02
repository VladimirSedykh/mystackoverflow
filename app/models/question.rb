class Question < Post
	has_many :answers
	default_scope { where(is_question: true) }
	

end