class TaggedUser < ApplicationRecord
	belongs_to :user
	belongs_to :post
end
