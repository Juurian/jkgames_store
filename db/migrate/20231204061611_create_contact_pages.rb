class CreateContactPages < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_pages do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.text :message_text

      t.timestamps
    end
  end
end
