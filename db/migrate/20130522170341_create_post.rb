class CreatePost < ActiveRecord::Migration
  def up
  	create_table :posts do |t|
  		t.integer :user_id
  		t.string  :title
  		t.text    :body

      t.text    :tags_list

  		t.integer :votes
  		t.integer :answers
  		t.integer :view

  		t.boolean :is_question
  		t.timestamps   		
  	end
  end

  def down
  	drop_tabble :posts
  end
  
end
