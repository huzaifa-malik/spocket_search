class Product < ApplicationRecord
  serialize :tags, Array

  belongs_to :country

  validates_presence_of :title, :price, :description

  searchkick

  def search_data
    {
      title: title,
      description: description,
      country_id: country_id,
      country_name: country&.name,
      price: price,
      tags: tags.map { |tag| tag.downcase },
      created_at: created_at
    }
  end

end
