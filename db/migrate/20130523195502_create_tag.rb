class CreateTag < ActiveRecord::Migration
  def up
		create_table :tags do |t|
  		t.string  :name
  		t.text    :about
      t.integer :asked_count
      t.integer :question_count

  		t.timestamps   
  	end
  end

  def down
  	drop_tabble :tags
  end
end
