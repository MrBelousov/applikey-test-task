class CreatePostComments < ActiveRecord::Migration
  def change
    create_table :post_comments do |t|
      t.integer :post_id, index: true
      t.integer :user_id, index: true
      t.string :comment_text

      t.timestamps null: false
    end
  end
end
