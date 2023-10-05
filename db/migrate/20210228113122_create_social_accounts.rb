class CreateSocialAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :social_accounts do |t|
      t.references :user
      t.references :authentication_provider
      t.string :token
      t.string :secret
      t.timestamps
    end
  end
end
