class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    
    # เพิ่มความสามารถให้ Post รองรับการกดไลค์ (acts_as_votable)
    acts_as_votable
  end
  
  
