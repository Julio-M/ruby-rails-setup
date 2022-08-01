class AppointmentsController < ApplicationController
  before_action :find_ap, only: %i[show destroy]
  before_action :find_appointments_by_time_from_doc, only: %i[create]
  before_action :find_ap_day, only: %i[get_app_for_day]
  
  def index
    appointments = Appointment.all
    render json: appointments
  end 

  def show
    render json: @ap
  end

  #show list of all appointments for specific doctor
  def show_doc_ap
      render json:@doc_ap
  end

  # def show_pat_ap
  #     render json:@pat_ap
  # end

  def get_app_for_day
    if @ap_day.count>0
      render json:@ap_day
    else
      render json:{
        error: "No appointments today"
        },
        status: :ok
    end
  end


  def destroy
      @ap.destroy
      head :no_content
  end

  def create
    if @ap_time<3
      new_appointment = Appointment.create!(ap_params)
      render json: new_appointment, status: :created
    else
      render json:{
        error: "Too many appointmets at the same time"
        },
        status: :ok
    end
  end

  private

  def find_ap
    @ap = Appointment.find(params[:id])
  end

  def find_appointments_by_time_from_doc
    @ap_time = Appointment.where(doctor_id:params[:doctor_id],appointment_time:params[:appointment_time]).count
  end

  def find_ap_day
    @ap_day = Appointment.where(appointment_time:params[:day])
  end

  def find_doc_ap
      @doc_ap = Appointment.where(doctor_id:params[:id])
  end

  def ap_params
    ap_with_doc_pat = Appointment.where(doctor_id: params[:doctor_id], patient_id:params[:patient_id]).count
    if ap_with_doc_pat>0
      kind = "Follow up"
    else
      kind = "New patient"
    end
    params.permit(:doctor_id, :patient_id, :appointment_time).with_defaults(:kind =>kind)
  end

end