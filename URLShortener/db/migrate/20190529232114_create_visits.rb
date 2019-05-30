class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.integer :user_id, null: false
      t.integer :su_id, null: false
      t.timestamps
    end

    add_index :visits, :user_id
    add_index :visits, :su_id
  end
end
