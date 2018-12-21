require 'rqrcode'

class MainController < ApplicationController

  def index
    @image = Content.where(page: "home", section: "image").first
    @box = Content.where(page: "home", section: "box").first
    @announcement = Content.where(page: "home", section: "announcement").first
  end

  def instructors
  end

  def studio
    @content = Content.where(page: "studio").first
    @instructors = Instructor.all
  end

  def schedule
    @content = Content.where(page: "schedule").first
  end

  def studio_events
  end
end
