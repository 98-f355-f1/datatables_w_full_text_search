# frozen_string_literal: true

class EmployeesController < ApplicationController
  include SortableColumnsHelper
  include PagyHelper

  before_action :set_employee, except: %i[index new create]
  before_action :set_pagy_and_employees, only: :index

  # GET /employees or /employees.json
  def index
    render Employees::EmployeesIndexComponent.new(employees: @employees, pagy: @pagy).with_flash_content(@notice.to_s)
  end

  # GET /employees/1 or /employees/1.json
  def show
    respond_to do |format|
      format.json { render json: { employee: @employee.to_json, content: @employee.fts_employee.content.to_json } }
      format.html
    end
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # POST /employees or /employees.json
  def create
    company = Company.find(1)
    @employee = company.employees.create(employee_params)

    respond_to do |format|
      if @employee.safe_save
        set_employee_count

        format.turbo_stream
      else
        format.turbo_stream { render :create_failed }
      end
    end
  end

  # GET /employees/1/edit
  def edit; end

  # PATCH/PUT /employees/1/cancel_edit
  def cancel_edit
    respond_to do |format|
      format.json { render json: { employee: @employee.to_json, content: @employee.fts_employee.content.to_json } }
      format.turbo_stream
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.safe_update(employee_params)
        format.turbo_stream
      else
        format.turbo_stream { render :edit }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.safe_destroy
    set_employee_count

    respond_to(&:turbo_stream)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:name, :position, :office, :age, :start_date)
  end

  def set_employee_count
    @count = Employee.async_count
  end

  def set_pagy_and_employees
    @pagy, @employees = pagy_custom(
      Employee.build_search(params).reorder(
        sort_column(Employee) => sort_direction
      ),
      page: params.fetch(:page, 1),
      items: params.fetch(:count, 10),
      request_path: url_for(action: "index", controller: controller_name, only_path: true)
    )
  end
end
