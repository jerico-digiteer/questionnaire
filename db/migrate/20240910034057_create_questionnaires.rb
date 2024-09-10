class CreateQuestionnaires < ActiveRecord::Migration[7.2]
  def change
    create_table :questionnaires do |t|
      t.string :name

      t.timestamps
    end
  end
end
