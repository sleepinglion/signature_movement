class CreateAdminLoginLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_login_logs do |t|
      t.references :admin, null: false
      t.integer :client_ip, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps
    end
  end
end
