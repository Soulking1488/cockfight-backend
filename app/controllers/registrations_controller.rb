class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    @user.wallet_balance ||= 1000.00 # Give new owners satire starting cash!

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created! You have been credited 1,000 satire bucks."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
