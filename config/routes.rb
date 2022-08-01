Rails.application.routes.draw do

  v1 = '/api/v1/'
  
  resources :patients, path:"#{v1}/patients", only: %i[index show]
  resources :appointments, path:"#{v1}/appointments", only: %i[index show]
  resources :doctors, path:"#{v1}/doctors", only: %i[index show]

  #routes for doctors
  post "#{v1}/doctors", to:"doctors#create"
  delete "#{v1}/doctors/:id", to: "doctors#destroy"
  delete "#{v1}/doctors/:id/appointment/:ap_id", to: "doctors#destroy_the_appointment"
  get "#{v1}/doctors/:id/day/:day", to: "doctors#get_appointments_day"
  get "#{v1}/doctors/:id/all_appointments", to: "doctors#get_all_appointments"


  #routes for patients
  post "#{v1}/patients", to:"patients#create"
  delete "#{v1}/patients/:id", to: "patients#destroy"

  #routes for appointments
  post "#{v1}/appointments", to:"appointments#create"
  delete "#{v1}/appointments/:id", to: "appointments#destroy"
  get "#{v1}/appointments/day/:day", to: "appointments#get_app_for_day"

  # Routing logic: fallback requests for React Router.
  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }
end
