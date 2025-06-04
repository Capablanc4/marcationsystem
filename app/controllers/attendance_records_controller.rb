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
      if @attendance.errors[:record_type].any?
      flash.now[:alert] = "Ya has registrado '#{@attendance.record_type.humanize}' hoy"
      else
        flash.now[:alert] = @attendance.errors.full_messages.join(", ")
      end
      render :new, status: :unprocessable_entity
    end
  end

  private
  def attendance_params
    params.require(:attendance_record).permit(:record_type, :comment)
  end
end
