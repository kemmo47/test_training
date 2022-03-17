class Todos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :todo_info
      t.integer :todo_complete

      t.timestamps
    end
  end
end
