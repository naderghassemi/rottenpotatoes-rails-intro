module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def title_header_class(params)
    if params[:sort] == 'title' then 'hilite' end
  end

  def release_date_header_class(params)
    if params[:sort] == 'release_date' then 'hilite' end
  end
end
