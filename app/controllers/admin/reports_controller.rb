class Admin::ReportsController < Admin::AdminController
  before_action :set_admin_report, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_main_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.report')
  end

  # GET /admin/reports
  # GET /admin/reports.json
  def index
    @admin_reports = Report.order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_reports }
    end
  end

  # GET /admin/reports/1
  # GET /admin/reports/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_report }
    end
  end

  # GET /admin/reports/new
  # GET /admin/reports/new.json
  def new
    @admin_report = Report.new
    @admin_report.build_report_content

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_report }
    end
  end

  # GET /admin/reports/1/edit
  def edit
  end

  # POST /admin/reports
  # POST /admin/reports.json
  def create
    @admin_report = Report.new(admin_report_params)

    respond_to do |format|
      if @admin_report.save
        format.html { redirect_to admin_reports_url, notice: @controller_name + t(:message_success_create) }
        format.json { render json: @admin_report, status: :created, location: @admin_report }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/reports/1
  # PUT /admin/reports/1.json
  def update
    respond_to do |format|
      if @admin_report.update_attributes(admin_report_params)
        format.html { redirect_to admin_reports_url, notice: @controller_name + t(:message_success_update) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/reports/1
  # DELETE /admin/reports/1.json
  def destroy
    @admin_report.destroy

    respond_to do |format|
      format.html { redirect_to admin_reports_path}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_report
    @admin_report = Report.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_report_params
    params.require(:report).permit(:report_category_id, :title, :enable, report_content_attributes: [:id, :content]).merge(user_id: current_admin.id)
  end
end
