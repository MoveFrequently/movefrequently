class Admin::ExercisesController < AdminController
  before_action :set_admin_exercise, only: %i[ show edit update destroy preview]

  # GET /admin/exercises or /admin/exercises.json
  def index
    order_criteria = params[:order] || "created_at ASC"
    scope = Admin::Exercise

    if params[:show_inactive] == "true"
      scope = scope.unscoped
    end

    @admin_exercises = scope.order(order_criteria).page(params[:page])
  end

  # GET /admin/exercises/1 or /admin/exercises/1.json
  def show
  end

  # GET /admin/exercises/new
  def new
    @admin_exercise = Admin::Exercise.new
  end

  # GET /admin/exercises/1/edit
  def edit
  end

  # POST /admin/exercises or /admin/exercises.json
  def create
    @admin_exercise = Admin::Exercise.new(admin_exercise_params)

    respond_to do |format|
      if @admin_exercise.save
        format.html { redirect_to @admin_exercise, notice: "Exercise was successfully created." }
        format.json { render :show, status: :created, location: @admin_exercise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/exercises/1 or /admin/exercises/1.json
  def update
    respond_to do |format|
      if @admin_exercise.update(admin_exercise_params)
        format.html { redirect_to @admin_exercise, notice: "Exercise was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_exercise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/exercises/1 or /admin/exercises/1.json
  def destroy
    @admin_exercise.destroy!

    respond_to do |format|
      format.html { redirect_to admin_exercises_path, status: :see_other, notice: "Exercise was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def preview
    @exercise = Admin::Exercise.unscoped.find(params.expect(:id))
    render template: "exercises/show"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_exercise
      @admin_exercise = Admin::Exercise.unscoped.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def admin_exercise_params
      params.fetch(:admin_exercise, {}).permit(:name, :description, :custom_instructions, { steps: [] }, :active_at, :active)
    end
end
