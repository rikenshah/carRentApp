require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  	test "should not have reservation without user id" do
  		res = Reservation.new
  		assert_not res.save, "Saved the reservation without a user"
	end

	test "should not have reservation without car id" do
		res = Reservation.new
  		assert_not res.save, "Saved the reservation without a car"
	end
end
