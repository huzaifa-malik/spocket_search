module Products
  class SearchService
    PER_PAGE = 15

    PRODUCTS_SORT_OPTIONS = [
      ['Relevance', 'relevance'],
      ['Newest', 'newest'],
      ['Lowest Price', 'lowest_price'],
      ['Highest Price', 'highest_price']
    ]

    PRODUCT_PRICE_VARIANTS = [
      ['Equal To', 'equal_to'],
      ['Less Than', 'less_than'],
      ['Greater Than', 'greater_than'],
    ]
    def apply_search(search_params)
      search_options = {
        page: search_params[:page],
        per_page: PER_PAGE
      }

      query = search_params[:title].present? ? search_params[:title] : '*'
      search_options = prepare_search_filters(search_options, search_params)
      Product.search query, search_options
    end

    def prepare_search_filters(search_options, search_params)
      search_options = set_sort_filters(search_options, search_params[:sort])

      search_options[:where] = prepare_where_clause(search_params)
      search_options[:match] = :word_start

      search_options
    end

    def set_sort_filters(search_options, sort_by)
      case sort_by
      when 'relevance'
        search_options[:fields] = ["title^2", "description"]
      when 'newest'
        search_options[:order] = { created_at: :desc }
      when 'lowest_price'
        search_options[:order] = { price: :asc }
      when 'highest_price'
        search_options[:order] = { price: :desc }
      end
      search_options
    end

    def prepare_where_clause(search_params)
      limit_by_price(search_params)
      limit_by_country(search_params)
      limit_by_tags(search_params)

      where_object
    end

    def where_object
      @where ||= {}
    end

    def limit_by_price(search_params)
      return unless search_params[:price].present?
      price_filter = {}
      price_filter[:gt] = search_params[:price] if search_params[:price_variant] == 'greater_than'
      price_filter[:lt] = search_params[:price] if search_params[:price_variant] == 'less_than'
      price_filter = search_params[:price] if search_params[:price_variant] == 'equal_to'

      where_object[:price] = price_filter
    end

    def limit_by_country(search_params)
      where_object[:country_id] = search_params[:country_id].to_i if search_params[:country_id].present?
    end

    def limit_by_tags(search_params)
      return unless search_params[:tags].present?
      tags = search_params[:tags].split(',').map { |tag| tag.strip.downcase }

      where_object[:tags] = tags
    end

  end
end
