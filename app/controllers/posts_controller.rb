class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # เพิ่มการตรวจสอบล็อกอิน
  before_action :set_post, only: %i[show edit update destroy like]  # เพิ่ม :like ใน before_action

  # GET /posts or /posts.json
  def index
    if params[:query].present?
      # ค้นหาโพสต์โดยใช้คำค้นหาใน title หรือ content
      @posts = Post.where("title LIKE ? OR content LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      # แสดงโพสต์ทั้งหมดหากไม่มีคำค้นหา
      @posts = Post.all
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    # ดึงคอมเมนต์ทั้งหมดที่เกี่ยวข้องกับโพสต์นี้
    @comments = @post.comments.order(created_at: :desc)  # คอมเมนต์ที่แสดงในลำดับเวลาจากใหม่ไปเก่า
    @comment = Comment.new  # ฟอร์มสำหรับการคอมเมนต์ใหม่
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # เพิ่ม action like ที่จะเพิ่มจำนวน likes ให้โพสต์
  def like
    @post.liked_by current_user  # ใช้ฟังก์ชันจาก acts_as_votable ที่จะเพิ่มไลค์ให้โพสต์

    redirect_to @post, notice: 'You liked this post!'  # เมื่อกดไลค์เสร็จแล้ว เปลี่ยนเส้นทางกลับไปที่หน้าโพสต์
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id]) # ดึงโพสต์จากฐานข้อมูลโดยใช้ id
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content)  # ไม่มี :likes ใน params เพราะ acts_as_votable ไม่ใช้คอลัมน์นี้
  end
end
