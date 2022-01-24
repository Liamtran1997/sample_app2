class UsersController < ApplicationController
   before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
   before_action :correct_user, only: [:edit, :update]
   before_action :admin_user, only: :destroy
   # Chi khi dung User dang nhap moi co the tu edit va update chinh ban than

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

   def destroy
     User.find(params[:id].destroy)
     flash[:success] = "User deleted"
     redirect_to users_path
   end

   def index
     @users = User.paginate(page: params[:page])
   end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email # Send activation to own email
      flash[:info] = "Please check your email to activate your account." # This one show the message to display when register success
      redirect_to root_url # That's mean redirect_to user_url(@user)
    else
      render 'new'
    end
  end


  def edit
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now[:success] = "Uppdated Account Successfully!"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private
    def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
    end

    # Before filters
    # Confirms a logged-in user.

     def correct_user
       @user = User.find(params[:id])
       redirect_to(root_url) unless current_user?(@user) # Tra lai trang chu neu @user khong phai la user hien tai
     end

   # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin? # Tra lai trang chu neu user nay khong phai la admin
    end

end
