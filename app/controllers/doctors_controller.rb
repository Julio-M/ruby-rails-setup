class DoctorsController < ApplicationController
  before_action :find_doctor, only: %i[show destroy]
  before_action :find_appoint_day, only: %i[get_appointments_day]
  before_action :find_all_appointments, only: %i[get_all_appointments]
  before_action :find_appoint_destroy, only: %i[destroy_the_appointment]

  #show list of all doctors
  def index
    doctors = Doctor.all
    render json: doctors
  end

  #show doctor by id
  def show
    render json: @doctor
  end

  #create a new doctor
  def create
    doctor = Doctor.create!(doctor_params)
    render json: doctor, status: :created
  end
 
  # delete a doctor
  def destroy
    @doctor.destroy
    head :no_content
  end

  #show appointments for day
  def get_appointments_day
    if @appointments.count>0
      render json: @appointments
    else
      render json:{
        error: "No appointments found on this date"
        },
        status: :ok
    end
  end

  #show all appointments for doctor
  def get_all_appointments
    if @all_appointments.count>0
      render json: @all_appointments, status: :ok
    else
      render json:{
        error: "No appointments yet"
        },
        status: :ok
    end
  end

  #delete a specific appointment
  def destroy_the_appointment
    @destroy_appointment.destroy
    head :no_content
  end

  private  

  # find doctor by id
  def find_doctor
   @doctor = Doctor.find(params[:id])
  end

  #find appointments by day
  #Ideally the table for the appoinments would have separte day and time but due to lack of time I didn't change it at the moment
  def find_appoint_day
    ar = Doctor.find(params[:id]).appointments
    days = ar.map{|ap| ap if ap.appointment_time.to_date==params[:day].to_date}
    @appointments = days.compact
  end

  #find all appointments given the doctor's id
  def find_all_appointments
    @all_appointments = Doctor.find(params[:id]).appointments.all
  end

  #find appoinment given doctor's id and appointmet's id
  def find_appoint_destroy
    @destroy_appointment = Doctor.find(params[:id]).appointments.find(params[:ap_id])
  end

  #parameters allowed for creating
  def doctor_params
    params.permit(:first_name,:last_name)
  end

end