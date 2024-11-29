class User < ApplicationRecord
  # Ensure Devise modules or other relationships are defined
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Add this line to enable voting functionality
  acts_as_voter
end

