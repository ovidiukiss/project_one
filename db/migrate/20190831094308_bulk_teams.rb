class BulkTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :bulks do |t|
      t.string :name
      t.string :filename
      t.string :content_type
    end
  end
end
