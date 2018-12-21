class InstructorsController < ApplicationController

  def index
    @instructors = Instructor.all.reorder('view_order asc')
  end

  def show
    @instructor = Instructor.find(params[:id])
    @classes = @instructor.get_classes
  end

  def edit
    @instructor = Instructor.find(params[:id])
    @classes = @instructor.get_classes
  end

  def update
    @instructor = Instructor.find(params[:id])
    @instructor.update_attributes(params.require(:instructor).permit(:name, :title, :playlist, :fb_handle, :fb_link, :ig_handle, :ig_link, :bio))

    redirect_to instructor_url(@instructor)
  end
end
