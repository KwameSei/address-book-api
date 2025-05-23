module PaginationHelper
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10
  MAX_PER_PAGE = 100

  def paginate(scope, params)
    page = (params['page'] || DEFAULT_PAGE).to_i
    per_page = [(params['per_page'] || DEFAULT_PER_PAGE).to_i, MAX_PER_PAGE].min

    total_count = scope.count
    total_pages = (total_count / per_page.to_f).ceil

    {
      records: scope.limit(per_page).offset((page - 1) * per_page),
      meta: {
        current_page: page,
        per_page: per_page,
        total_count: total_count,
        total_pages: total_pages
      }
    }
  end
end