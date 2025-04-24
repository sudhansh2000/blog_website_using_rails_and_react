class V1:: UsersController < ApplicationController
  # skip the authetication part in the controller
  skip_before_action :verify_authenticity_token
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to @user }
        format.json { render json: @user, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @user = User.new(user_params)
    puts @user
    if @user.save
      render json: { user: @user, message: "User created successfully" }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :user_name,
      :email, :phone_number, :password,
      :dob, :is_active
    )
  end
end
