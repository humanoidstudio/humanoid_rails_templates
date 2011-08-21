class Role < ActiveRecord::Base
  attr_accessible :title
  has_many :users
  
  def to_s
    "#{self.title}"
  end
  
end
