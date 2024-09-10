class CreateResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :responses do |t|
      t.references :questionnaire, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :response_text

      t.timestamps
    end
  end
end
