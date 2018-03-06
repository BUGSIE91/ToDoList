class CreateChecklists < ActiveRecord::Migration[5.1]
  def change
    create_table :checklists do |t|
      t.string :task_name
      t.string :priority
      t.string :notes
      t.boolean :completed
      t.integer :user_id
      
      t.timestamps
    end
  end
end
