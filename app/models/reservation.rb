class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car
  attr_accessor :can_checkout, :can_return, :can_reserve, :checked_out, :returned
end
