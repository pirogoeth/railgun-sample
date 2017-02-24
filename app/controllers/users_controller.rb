# require 'app/mailers/default_mailer'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :send_user_messages]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        send_messages

        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /users/1/send_user_messages
  # GET /users/1/send_user_messages.json
  def send_user_messages
    begin
      send_messages
    rescue Exception => exc
      respond_to do |format|
        format.html { redirect_to @user, notice: 'Could not send mails. Check console.' }
        format.json { render :show, status: :mail_failed, location: @user }
      end

      raise exc
    end

    respond_to do |format|
      format.html { redirect_to @user, notice: 'User mails have been sent.' }
      format.json { render :show, status: :mail_success, location: @user }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :address, :login)
    end

    def send_messages
      message = DefaultMailer.welcome_message(@user)
      # Here, you can add custom values to the `mailgun_` attributes
      # on your message to provide headers, options, variables, and
      # recipient vars to the Mailgun API.
      message.mailgun_options ||= { "tracking-opens" => "true" }
      message.mailgun_headers ||= {
        "X-Rails-Sender" => "users_controller",
      }

      # Make sure you send the message!
      message.deliver_now

      # Send a separate Railgun Info message...
      message = DefaultMailer.railgun_info(@user)
      # Here, you can add custom values to the `mailgun_` attributes
      # on your message to provide headers, options, variables, and
      # recipient vars to the Mailgun API.
      message.mailgun_options ||= { "tracking-opens" => "true" }
      message.mailgun_headers ||= {
        "X-Rails-Sender" => "users_controller",
      }

      # Deliver it!
      message.deliver_now
    end

end
