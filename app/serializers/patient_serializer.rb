class PatientSerializer < ActiveModel::Serializer
  attributes :id, :full_name
  has_many :appointments

  def full_name
    return full_name = object.first_name + ' ' + object.last_name
  end

end
