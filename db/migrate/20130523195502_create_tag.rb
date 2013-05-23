class CreateTag < ActiveRecord::Migration
  def up
		create_table :tags do |t|
  		t.string  :name
  		t.text    :about
  		t.text    :related_tags
  		t.int     :questions_tagged

  		t.timestamps   
  end

  def down
  	drop_tabble :tags
  end
end
