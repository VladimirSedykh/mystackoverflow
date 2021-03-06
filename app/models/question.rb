class Question < Post
  has_many :answers
  has_many :question_tags
  has_many :tags, :through => :question_tags

  default_scope { where(is_question: true) }
  AVAILABLE_TABS = ["today", "week", "month", "fre"]

  def self.by_tab(tab, user)
    if tab == "my"
      Question.my(user) 
    elsif AVAILABLE_TABS.include?(tab)
      Question.send(tab)
    else
      Question.all
    end
  end 
end