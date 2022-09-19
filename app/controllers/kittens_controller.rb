class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:success] = "Your kitten has been created!"
      redirect_to @kitten
    else
      flash.now[:error] = "The kitten couldn't be created."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash[:success] = "Your kitten hsa been updated!"
      redirect_to @kitten
    else
      flash[:error] = "The kitten couldn't be updated."
      render :edit
    end

  end

  def destroy
    @kitten = Kitten.find(params[:id])
    if @kitten.destroy
      flash[:notice] = "Your kitten has been deleted!"
      redirect_to root_path
    end
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end

end
