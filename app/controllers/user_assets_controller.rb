class UserAssetsController < AssetsController

  before_filter :load_attachable
  before_filter :load_asset, :except => [ :index, :create, :new ]
  before_filter :check_auth, :only => protected_actions

protected

  # assets() is used for find() and build()
  delegate :assets, :to => '@attachable'
  helper_method :assets

  def load_asset
    @asset = assets.find(params[:id])
  end

  def load_attachable
    # We do both @user and @attachable because @attachable is used by the assets_controller
    # and @user is used when inferring missing path segments in the url helpers
    @user = @attachable = User.find_by_param(params[:user_id])
  end

  # This is implemented on a per-polymorph basis because the asset.attachable may be
  # an object that is *indirectly* tied to the current user.
  def check_auth
    @user == current_user or raise AccessDenied
  end

public

  # GET /assets
  # GET /assets.xml
  def index
    @assets = @user.assets.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @assets.to_xml }
    end
  end

  # GET /assets/1
  # GET /assets/1.xml
  def show
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @asset.to_xml }
    end
  end

  # GET /assets/new
  def new
    @asset = assets.build
  end

  # GET /assets/1/  edit
  def edit
  end

  # POST /assets
  # POST /assets.xml
  def create
    @asset = assets.build(params[:asset])

    respond_to do |format|
      if @asset.save
        flash[:notice] = 'Asset was successfully created.'
        format.html { redirect_to asset_url(@asset) }
        format.xml  { head :created, :location => asset_url(@asset) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors.to_xml }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.xml
  def update
    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        flash[:notice] = 'Asset was successfully updated.'
        format.html { redirect_to asset_url(@asset) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors.to_xml }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.xml
  def destroy
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to user_user_assets_url() }
      format.xml  { head :ok }
    end
  end

end