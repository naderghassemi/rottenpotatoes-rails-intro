class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    redirect = false

    if params.has_key?(:sort) && !params[:sort].nil?
      @sort = params[:sort] # Get sorting info from URL params
      session[:sort] = @sort
    elsif session.has_key?(:sort) && !session[:sort].nil?
      @sort = session[:sort] # Get sorting info from session cookie
      redirect = true
    else
      @sort = :id # Just sort by ID by default
    end

    if params.has_key?(:ratings) && !params[:ratings].nil?
      @checked_ratings = params[:ratings].keys # Get checked ratings from URL params
      session[:checked_ratings] = @checked_ratings
    elsif session.has_key?(:checked_ratings) && !session[:checked_ratings].nil?
      @checked_ratings = session[:checked_ratings] # Get checked ratings from session cookie
      redirect = true
    else
      @checked_ratings = @all_ratings # All ratings checked by default
    end

    if redirect # To keep it RESTful, we may need to redirect using the session params
      flash.keep # Don't overwrite a recent flash notice
      redirect_to movies_path(:sort => @sort, :ratings => Hash[@checked_ratings.map {|rating| [rating, 1]}])
    end

    # Do a single database query with ordering and filtering
    @movies = Movie.where({rating: @checked_ratings}).order(@sort)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
