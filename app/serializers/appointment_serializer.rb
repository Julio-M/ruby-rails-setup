class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :doctor_id, :patient_id, :appointment_time, :kind

  belongs_to :patient
end
