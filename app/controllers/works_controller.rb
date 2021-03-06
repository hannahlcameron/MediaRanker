class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]

  def index
    @works = Work.all
    @albums = Work.where(category: 'album')
    @books = Work.where(category: 'book')
    @movies = Work.where(category: 'movie')

  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully saved #{work_params[:category]} #{work_params[:id]}"
      redirect_to work_path(@work)
    else
      flash[:failure] = "A problem occurred: Could not create #{work_params[:category]}"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    @work.assign_attributes(work_params)

    if @work.save
      flash[:success] = "Successfully saved #{params[:category]} #{params[:work_id]}"
      redirect_to work_path(@work)
    else
      flash[:failure] = "A problem occurred: Could not update #{params[:category]}"
      render :edit
    end
  end

  def destroy
    Work.destroy(params[:id])
    flash[:success] = "Successfully destroyed #{params[:category]} #{params[:work_id]}"
    redirect_to works_path
  end

  def topmedia
    @albums = Work.where(category: 'album')
    @books = Work.where(category: 'book')
    @movies = Work.where(category: 'movie')
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find(params[:id])

  end
end
