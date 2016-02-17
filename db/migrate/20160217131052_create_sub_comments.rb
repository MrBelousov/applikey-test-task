class CreateSubComments < ActiveRecord::Migration
  def change
    create_table :sub_comments do |t|
      t.integer :post_comment_id
      t.integer :user_id
      t.string :comment_text

      t.timestamps null: false
    end
  end
end
