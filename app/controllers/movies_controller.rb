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

    if params.has_key?(:sort)
      @sort = params[:sort]
      session[:sort] = @sort
    elsif session.has_key?(:sort)
      @sort = session[:sort]
    else
      @sort = :id
    end

    if params.has_key?(:ratings)
      @checked_ratings = params[:ratings].keys
      session[:checked_ratings] = @checked_ratings
    elsif session.has_key?(:checked_ratings)
      @checked_ratings = session[:checked_ratings]
    else
      @checked_ratings = @all_ratings
    end

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
