class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.string :title
      t.integer :sequence_number, default: 1
      t.references :content, foreign_key: true

      t.timestamps
    end
  end
end
