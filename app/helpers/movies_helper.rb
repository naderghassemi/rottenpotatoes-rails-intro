module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def header_class(header)
    if @sort == header then 'hilite' end
  end

  def checked(rating)
    if @checked_ratings.nil?
        @checked_ratings = Movie.all_ratings
    end
    return @checked_ratings.include?(rating)
  end
end
