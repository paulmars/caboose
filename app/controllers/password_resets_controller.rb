class PasswordResetsController < ApplicationController

  layout "1col"

  def new
    @password_reset = PasswordReset.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @password_reset }
    end
  end

  def edit
    @password_reset = PasswordReset.find_by_token(params[:token])
    if @password_reset.user
      self.current_user = @password_reset.user
      self.current_user.remember_me
      cookies[:auth_token] = { :value => self.current_user.remember_token,
                               :expires => self.current_user.remember_token_expires_at }
    end
  end

  def create
    @password_reset = PasswordReset.new(params[:password_reset])
    @password_reset.user = User.find_by_email(@password_reset.email)

    respond_to do |format|
      if @password_reset.save
        PasswordNote.deliver_password_reset(@password_reset)
        flash[:notice] = 'Password reset was successful. Check your email.'
        format.html
        format.xml  { render :xml => @password_reset, :status => :created, :location => @password_reset }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @password_reset.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @password_reset = PasswordReset.find_by_token(params[:token])
    user = @password_reset.user if @password_reset

    respond_to do |format|
      if user and user.update_attributes(params[:user])
        @password_reset.destroy
        flash[:notice] = 'Password was successfully updated.'
        format.html { redirect_to(user) }
        format.xml  { head :ok }
      else
        flash[:notice] = 'An error has occured, try again?'
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
