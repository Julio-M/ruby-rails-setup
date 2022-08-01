class PatientsController < ApplicationController
  before_action :find_patient, only: %i[show update destroy]

  #show a list of all patients
  def index
    patients = Patient.all
    render json: patients
  end

  #show a single patient
  def show
    render json: @patient
  end

  #create a new patient
  def create
    patient = Patient.create!(patient_params)
    render json: patient, status: :created
  end

  #delete a new patient
  def destroy
    @patient.destroy
    head :no_content
  end

  private  

  def find_patient
   @patient = Patient.find(params[:id])
  end

  def patient_params
    params.permit(:first_name,:last_name)
  end

end