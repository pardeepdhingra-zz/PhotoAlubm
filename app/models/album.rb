class Album < ActiveRecord::Base
   attr_accessible :title
   has_many :pictures ,:dependent=>:destroy
end
