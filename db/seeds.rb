# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Tags creation.
3.times do |i|
  Tag.create(name:"#Tag#{i}", about:"Description Tag#{i}.")
end 

# User creation.
5.times do |i|
  user = User.create({email: "SWA88#{i}@mail.ru", password: '11111111'})
  3.times do |j|
    question = user.questions.create(title: "Question #{rand(100)}", body: "Content of the question.")
    2.times do |k|
      QuestionTag.create(question: question, tag: Tag.all.shuffle.first)
    end    
  end
end

# Answers create.
Question.all.each do |question|  
  2.times do |i|
    user = User.all.shuffle.find{|u| u.id != question.user_id}
    question.answers.create(title: "Answer #{question.id}", body: "Content of the answer.", user_id: user.id)
  end
  
end



