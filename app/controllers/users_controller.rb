class UsersController < Clearance::UsersController
  before_action :find_user, except: [:new, :create]
  before_action :delete_session_if_completed

  def new
    if session[:user_id].present?
      @user = User.find(session[:user_id])
      @user.build_situation && @user.build_technical_info
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.filled_first_form!
      session[:user_id] = @user.id
      redirect_to sign_up_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.first_step?
      @user.filled_first_form!
      redirect_to sign_up_path
    elsif @user.second_step?
      @user.last_step!
      sign_in @user
      redirect_back_or url_after_create
    end
    @user.update_attributes(user_params)
  end

  def back
    @user = User.find(session[:user_id]) if session[:user_id].present?
    @user.modify_first_form!
    redirect_to sign_up_path
  end

  private

  def delete_session_if_completed
    if session[:user_id].present?
      user = User.find(session[:user_id])
      if user.completed?
        session[:user_id] = nil
      end
    end
  end

  def find_user
    if session[:user_id].present?
      @user = User.find(session[:user_id])
    else
      @user = User.find(params[:id])
    end
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :street, :number,
                                 :zip, :city, :situation, :technical_info,
                                 situation_attributes: [:id, :move_in, :new_house, :new_access],
                                  technical_info_attributes: [:id, :pdl])
  end
end
