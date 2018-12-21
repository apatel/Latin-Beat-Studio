class PurchasesController < ApplicationController

  def add
    @user = current_user #User.find(params[:uid])
    @pass = Pass.find(params[:pid])
    Purchase.create(user: @user, pass: @pass)

    redirect_to accounts_path
  end
end
