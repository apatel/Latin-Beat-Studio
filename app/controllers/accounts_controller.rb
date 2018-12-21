class AccountsController < ApplicationController

  def index
    if !session[:member_selected].blank?
      @user = User.find(session[:member_selected])
    else
      @user = current_user
    end
    @class_registrations = @user.class_registrations.order(class_date: :asc)
    @purchases = @user.current_purchases
    @qrcode = RQRCode::QRCode.new("#{root_url}class_registrations/qr_scan?uid=#{@user.id}")
    @png = @qrcode.as_png.to_image.resize(400,400).to_data_url
  end

  def profile
    unless session[:member_selected].blank?
      @user = User.find(session[:member_selected])
    else
      @user = current_user
    end
    respond_to do |format|
      format.js { }
    end
  end

  def qr_code
    unless session[:member_selected].blank?
      @user = User.find(session[:member_selected])
    else
      @user = current_user
    end
    @qrcode = RQRCode::QRCode.new("#{root_url}class_registrations/qr_scan?uid=#{@user.id}")
    @png = @qrcode.as_png.to_image.resize(400,400).to_data_url
    respond_to do |format|
      format.js { }
    end
  end

  def classes
    unless session[:member_selected].blank?
      @user = User.find(session[:member_selected])
    else
      @user = current_user
    end
    @class_registrations = @user.class_registrations.where('class_date > ?', DateTime.now.in_time_zone("America/New_York")).order(class_date: :asc)
    respond_to do |format|
      format.js { }
    end
  end

  def past_classes
    unless session[:member_selected].blank?
      @user = User.find(session[:member_selected])
    else
      @user = current_user
    end
    @class_registrations = @user.class_registrations.where('class_date < ?', DateTime.now.in_time_zone("America/New_York")).order(class_date: :desc)
    respond_to do |format|
      format.js { }
    end
  end

  def packages
    unless session[:member_selected].blank?
      @user = User.find(session[:member_selected])
    else
      @user = current_user
    end
    if !params[:suspend].blank?
      package = Purchase.find(params[:pkg])
      package.suspend = params[:suspend]
      if params[:suspend] == "true"
        package.remaining_days = ((package.expire - Time.now) / 1.day).to_i
        package.suspend_start = Time.now
        package.class_registrations.where("class_date > ?", Time.now).delete_all
      elsif params[:suspend] == "false"
        package.suspend_end = Time.now
        package.expire = Time.now + (package.remaining_days + 1).days
      end
      package.save
    end

    if !params[:purchase].blank?
      purchase = Purchase.find(params[:purchase])
      if purchase.paid
        purchase.update(paid: false)
      else
        purchase.update(paid: true)
      end
      purchase.save
    end
    @purchases = @user.current_purchases
    respond_to do |format|
      format.js { }
    end
  end

  def past_packages
    unless session[:member_selected].blank?
      @user = User.find(session[:member_selected])
    else
      @user = current_user
    end
    @past_purchases = @user.past_purchases
    respond_to do |format|
      format.js { }
    end
  end

  def admin
    puts "in admin method"
    @today = User.where("EXTRACT(DAY FROM birthday) = ? AND EXTRACT(MONTH FROM birthday) = ?", Date.today.day, Date.today.month)
    @this_month = User.where("EXTRACT(DAY FROM birthday) >= ? AND EXTRACT(DAY FROM birthday) <= ? AND EXTRACT(MONTH FROM birthday) = ?", Date.today.day, 30, Date.today.month)
  end

  def member
    if !params[:query_id].blank? && params[:query_id].to_i > 0
      if !params[:query].blank? && params[:query].include?("(")
        @user = User.find(params[:query_id])
        session[:member_selected] = @user.id
        @message = "#{@user.username.capitalize} Selected"
      elsif !params[:query].blank?
        @results = User.where("lower(username) LIKE :query OR lower(first_name) LIKE :query OR lower(last_name) LIKE :query", query: "%#{params[:query].downcase}%")
        if @results.count > 0
          @message = "Please Choose Member"
        else
          @user = current_user
          @message = "No Member Found"
        end
      else
        @message = "No Query Submitted"
      end
    elsif !params[:query].blank?
      @results = User.where("lower(username) LIKE :query OR lower(first_name) LIKE :query OR lower(last_name) LIKE :query", query: "%#{params[:query].downcase}%")
      if @results.count > 0
        @message = "Please Choose Member"
      else
        @user = current_user
        @message = "No Member Found"
      end
    else
      @message = "No Query Submitted"
    end
    respond_to do |format|
      format.js { }
    end
  end

  def clear
    session[:member_selected] = nil
    redirect_to root_path
    puts "cleared member selected"
  end

  def autocomplete
    @users = User.order(:username).where("lower(username) LIKE ? or lower(first_name) LIKE ? or lower(last_name) LIKE ?", "%#{params[:term].downcase}%", "%#{params[:term].downcase}%", "%#{params[:term].downcase}%")
    respond_to do |format|
      format.html
      format.json {
        render json: @users.map { |u| { :label => u.autocomplete_name, :value => u.id } }.to_json
      }
    end
  end
end
