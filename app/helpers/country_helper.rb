module CountryHelper
  def country_select_all
    Country.all.map {|country| [country.name, country.id]}
  end
end
