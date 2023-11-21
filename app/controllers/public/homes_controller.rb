class Public::HomesController < ApplicationController
  def top
  end

  def about
  end

  def confirm
    @confirm = Confirm.find_by(name: params[:name])
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def unsubscribe
    @confirm = Confirm.find_by(name: params[:name])
  end
end
