class CommentsController < ApplicationController
  before_action :set_post  # เพิ่ม before_action เพื่อโหลดโพสต์ก่อน

  # Action สำหรับสร้างคอมเมนต์ใหม่
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user  # ผูกคอมเมนต์กับผู้ใช้ที่เข้าสู่ระบบ

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'There was an error creating the comment.'
    end
  end

  private

  # ฟังก์ชันที่ใช้โหลดโพสต์จาก params[:post_id]
  def set_post
    @post = Post.find(params[:post_id])
  end

  # ฟังก์ชันเพื่ออนุญาตให้ใช้ค่า body ในคอมเมนต์
  def comment_params
    params.require(:comment).permit(:body)  # เปลี่ยนจาก :content เป็น :body
  end
end
