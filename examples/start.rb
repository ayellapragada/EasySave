require_relative 'lib/sql_object'
require_relative 'test.rb'

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

