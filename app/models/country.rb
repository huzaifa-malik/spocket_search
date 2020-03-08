class Country < ApplicationRecord
  validates_uniqueness_of :name
end
