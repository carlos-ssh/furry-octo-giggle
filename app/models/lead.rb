class Lead < ApplicationRecord
  paginates_per 15

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Lead.create! row.to_hash
    end
  end
end
