class Car < ApplicationRecord
	validates_inclusion_of :status, :in => ['available','reserved','checked_out'], :default => 'available'
	validates_inclusion_of :style, :in => ['coupe','sedan','suv'], :default => 'sedan'
	validates_length_of :licence_plate, :is => 7, :unique => true
end
