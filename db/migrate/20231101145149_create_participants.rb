class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.string :email, null: false
      t.boolean :women_fashion_preference
      t.boolean :men_fashion_preference
      t.boolean :children_fashion_preference

      t.timestamps
    end
  end
end
