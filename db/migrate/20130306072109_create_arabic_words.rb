class CreateArabicWords < ActiveRecord::Migration
  def change
    create_table :arabic_words do |t|
      t.string :word
      t.integer :frequency

      t.timestamps
    end
  end
end
