class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.references :inviter, foreign_key: { to_table: :users }
      t.references :invitee, foreign_key: { to_table: :users }
      t.references :event, foreign_key: { to_table: :events }

      t.timestamps
    end
  end
end
