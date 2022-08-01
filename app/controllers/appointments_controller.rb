class AppointmentsController < ApplicationController
  before_action :find_ap, only: %i[show destroy]
  before_action :find_appointments_by_time_from_doc, only: %i[create]
  before_action :find_ap_day, only: %i[get_app_for_day]
  
  #show list of all apoinments
  def index
    appointments = Appointment.all
    render json: appointments
  end 

  #show specific appointment
  def show
    render json: @ap
  end


  # get appointment for the day
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

  # delete appoinment
  def destroy
      @ap.destroy
      head :no_content
  end

  #create new appointment with condition
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

  #find appoinments by time doctor id and appoinment time 
  def find_appointments_by_time_from_doc
    @ap_time = Appointment.where(doctor_id:params[:doctor_id],appointment_time:params[:appointment_time]).count
  end

  #find appointments by day
  #Ideally the table for the appoinments would have separte day and time but due to lack of time I didn't change it at the moment
  def find_ap_day
    ar=Appointment.all
    days = ar.map{|ap| ap if ap.appointment_time.to_date==params[:day].to_date}
    @ap_day=days.compact
  end

  #params for create and kind generator
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