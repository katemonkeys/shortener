class CreateLinksAgain < ActiveRecord::Migration
  def up
	create_table :links do |t|
		t.string :original
		t.string :shortened
		t.timestamps
	end
	add_index :links, :original
  end

    Link.create(original: "gofugyourself.celebuzz.com", 
    	shortened: "aaaaa")

  def down
    	drop_table :links
  end
end
