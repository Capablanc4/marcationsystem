class AttendanceRecordsController < ApplicationController
  before_action :authenticate_user!

  def index
  end
  def new
    @attendance = AttendanceRecord.new
  end

  def create
    @attendance = AttendanceRecord.new(attendance_params)
    @attendance.user_id = current_user.id
    @attendance.date = Time.zone.today
    @attendance.time = Time.zone.now
    if @attendance.save
      flash[:notice] = "Marcacion Registrada"
      redirect_to root_path
    else
      flash[:danger] = "No se ha podido registrar el evento"
      render :new, status: :unprocessable_entity
    end
  end

  private
  def attendance_params
    params.require(:attendance_record).permit(:record_type, :comment)
  end
end
