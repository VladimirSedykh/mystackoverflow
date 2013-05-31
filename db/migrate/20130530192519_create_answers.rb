class CreateAnswers < ActiveRecord::Migration
  def up
  	create_table :answers do |t|
  		t.integer :post_id
  		t.string  :title
  		t.text    :body

  		t.timestamps   		
  	end
  end

  def down
  	drop_tabble :answers
  end
end
