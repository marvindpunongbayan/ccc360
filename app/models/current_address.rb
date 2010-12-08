require_dependency "#{Rails.root}/vendor/plugins/common_engine/app/models/current_address.rb"

class CurrentAddress < Address
  validates :email, :email => true
end
