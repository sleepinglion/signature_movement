class CreateAdminPictures < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_pictures do |t|
      t.references :admin, null: false
      t.string :picture, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps
    end
  end
end
