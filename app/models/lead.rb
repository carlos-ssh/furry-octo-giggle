class Lead < ApplicationRecord
  paginates_per 15

  validates :first_name, presence: true
  validates :last_name, presence: true

  # REGEX VALIDATION
  REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: REGEX }
  validates :phone, presence: false, uniqueness: false


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Lead.create! row.to_hash
    end
  end
end
