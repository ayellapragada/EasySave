require_relative 'lib/easy_save.rb'

DBConnection.reset

class User < SQLObject 
  has_many :photos
  has_many :comments

  self.finalize!
end

class Photo < SQLObject
  has_many :comments
  belongs_to :user

  self.finalize!
end

class Comment < SQLObject
  belongs_to :user 
  belongs_to :photo

  self.finalize!
end

