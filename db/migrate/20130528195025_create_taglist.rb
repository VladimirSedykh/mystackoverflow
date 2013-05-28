class CreateTaglist < ActiveRecord::Migration
  def up
  	create_table :taglist do |t|
  		t.integer :post_id
  		t.integer :tag_id

  		t.timestamps   		
  	end
  end

  def down
  	drop_tabble :taglist
  end
end
