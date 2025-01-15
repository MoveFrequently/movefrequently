class Admin::FeaturesController < AdminController
  before_action :set_admin_feature, only: %i[ show edit update destroy ]

  # GET /admin/features or /admin/features.json
  def index
    @admin_features = Admin::Feature.all
  end

  # GET /admin/features/1 or /admin/features/1.json
  def show
  end

  # GET /admin/features/new
  def new
    @admin_feature = Admin::Feature.new
  end

  # GET /admin/features/1/edit
  def edit
  end

  # POST /admin/features or /admin/features.json
  def create
    @admin_feature = Admin::Feature.new(admin_feature_params)

    respond_to do |format|
      if @admin_feature.save
        format.html { redirect_to @admin_feature, notice: "Feature was successfully created." }
        format.json { render :show, status: :created, location: @admin_feature }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/features/1 or /admin/features/1.json
  def update
    respond_to do |format|
      if @admin_feature.update(admin_feature_params)
        format.html { redirect_to @admin_feature, notice: "Feature was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_feature }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/features/1 or /admin/features/1.json
  def destroy
    @admin_feature.destroy!

    respond_to do |format|
      format.html { redirect_to admin_features_path, status: :see_other, notice: "Feature was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_feature
      @admin_feature = Admin::Feature.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def admin_feature_params
      params.expect(admin_feature: [ :title, :feature ])
    end
end
