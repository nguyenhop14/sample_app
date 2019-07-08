class UsersController < ApplicationController
  before_action :load_user, except: %i(new create index)
  before_action :logged_in_user, except: %i(new create show)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def show
    return unless FILL_IN
  end

  def new
    @user = User.new
  end

  def index
    @users = User.activated.page(params[:page]).per Settings.user.per
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "controller.concerns.user.activate"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "controller.concerns.user.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controller.concerns.user.deleted"
      redirect_to users_path
    else
      render :show
  end

  private

    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def logged_in_user
      return if logged_in?
      store_location
      flash[:danger] = t "controller.concerns.user.login"
      redirect_to login_path
    end

    def correct_user
      redirect_to root_path unless current_user? @user
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def load_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:danger] = t("controllers.user.not_exits")
      redirect_to root_path
    end
end
