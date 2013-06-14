class CreateTaglist < ActiveRecord::Migration
  def up
  	create_table :question_tags do |t|
  		t.integer :question_id
  		t.integer :tag_id

  		t.timestamps   		
  	end
  end

  def down
  	drop_table :question_tags
  end
end
