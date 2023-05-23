class CreateModels < ActiveRecord::Migration[6.0]
  def change
    create_table :models do |t|
      t.references :user,:null=>false
      t.string :title, :null=>false, :limit=>60
      t.string :photo, :null=>false
      t.text :recommend_description, :null=>false
      t.text :models_comment, :null=>false
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps null: false
    end

    create_table :model_comments do |t|
      t.references :model,:null=>false
      t.references :user,:null=>false
      t.text :content,:null=>false
      t.boolean :enable, :null=>false, :default=>true      
      t.timestamps null: false
    end
  end
end
