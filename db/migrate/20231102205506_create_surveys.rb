class CreateSurveys < ActiveRecord::Migration[6.0]
  def change
    create_table :surveys do |t|
      t.string :question1
      t.string :question2
      t.string :question3
      t.string :question4
      t.references :participant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
