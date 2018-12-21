class ClassTypesController < ApplicationController
  def index
    @classes = ClassType.where(active: true)
  end
end
