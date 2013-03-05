class CreateCharacterConvertions < ActiveRecord::Migration
  def change
    create_table :character_convertions do |t|
      t.string :latin
      t.string :arabic

      t.timestamps
    end
  end
end
