class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  
  
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, null: false
      t.string :short_url
      t.integer :author_id, null: false
      t.timestamps

    end

    add_index :shortened_urls, :author_id
  end


end
