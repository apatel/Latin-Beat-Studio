class PassesController < ApplicationController
  def index
    @passes = {}
    Pass.all_categories.each do |cat|
      @passes[cat] = Pass.where(active: true, category: cat).reorder('view_order asc')
    end
    @passes.delete_if {|k, v| v.nil? || v.length == 0 }
    session[:pass_click] = true
  end

  def buy
    @pass = Pass.find(params[:pkg])
    unless session[:member_selected].blank?
      @user = User.find(session[:member_selected])
    else
      @user = current_user
    end

    #if package is single purchase, make sure it hasn't been purchased before
    if (@pass.single_purchase && !@user.previous_purchase?(@pass)) || !@pass.single_purchase
      #prevent multiple adds from refresh of page
      if session[:pass_click]
        @purchase = Purchase.create(user: @user, pass: @pass)
        session[:pass_click] = false
      end
      if current_user.admin?
        redirect_to accounts_path(query: @user.id), :flash => {success: 'You have successfully added the package.'}
      end
    else
      if current_user.admin?
        redirect_to accounts_path(query: @user.id), :flash => {success: 'You have successfully added the package.'}
      else
        redirect_to accounts_path, :flash => {danger: 'Package not added. You have previously purchased this single purchase package.'}
      end
    end
  end

  def remove
    purchase = Purchase.destroy(params[:p])
    #redirect to member account page
    if params[:a]
      # render packages_accounts_path, format: 'js'
      redirect_to accounts_path, :flash => {success: 'You have successfully removed the package from your account.'}
    else
      #canceled from buy page, redirect back to passes page
      redirect_to passes_path, :flash => {success: 'You have successfully removed the package from your account.'}
    end
  end
end
