class AddUserAndBodyToComments < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:comments, :user_id)  # ตรวจสอบว่า column 'user_id' มีอยู่แล้วหรือไม่
      add_reference :comments, :user, null: false, foreign_key: true
    end
    add_column :comments, :body, :text  # เพิ่มคอลัมน์ body เพื่อเก็บเนื้อหาคอมเมนต์
  end
end
