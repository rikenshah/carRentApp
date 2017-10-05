# Swift Car

### CSC/ECE 517 (OO Design and Development)

#### Following are the functionaltities as per requirements file.
- Login with admin/superadmin and create new car with same model and manufacturer. We can create new car by clicking on 'See all cars' and 'add new car'. This fucntionaity is available only to admins and superadmins.
- The status of a car in the system may have one of the three values: available, reserved and checked_out. Other values won't be allowed.
- Reservation creation process is as follows: See all cars, reserve, and enter check_out and return time.
- A user can reserve a car or rent a car without a previous reservation. A user is not allowed to have more than one car rented at a time. Only after canceling a reservation or returning a rented car, can a user can reserve or rent another car. -> Create reservation with one car and try to create new reservation. It should not allow. On deletion of reservation(by user/admin/superadmin) or on deletion of car(only by admin/superadmin), the user can again reserve a new car.
- The reservation process is automatic, and does not require an admin to approve requests. If the status of a car is “available” and a user rents it, the status of that car immediately transitions to “reserved”. But an admin can edit the reservation later. -> Also admin can change/create/delete the reservation later by using User Id and Car Id, which are visible on respective index pages.
- When a reservation is made, it must specify the time that the car is to be picked up (“checked out”) and returned. In order to simulate checkout and returns actions in the real world, there should be buttons that a user can manually click to indicate that a car has been checked out or returned ->There are buttons of check-out and return on reservations page. Also these buttons are visible only when applicable. If you havn't checked out, return button won't be visible. Also check-out button will be visible for 30min after check-out time.
- The minimum rental period is 1 hour and the maximum is 10 hours. The system should cancel a reservation if a user doesn’t check out a car in time. The time elasticity is 30 minutes after the pickup time.  For example, if a user reserved a car to pick up at 3:00pm, if the car was not checked out by 3:31pm, then the car should become “available” again.
- If a user doesn’t return a car on the date promised when it was checked out, the system will sent a notification (e.g. system message) to the user and automatically change the car status to “available”.


There will be three types of users in the system:
- Superadmin
    - **email : rikensuperadmin@gmail.com**
    - **password : rikensuperadmin**
    - Can do everything similar to admin, plus can manage admins.
    - Can create/edit/delete(except other superadmin)/view any type of user/reservation/car. Can not delete other superadmins.
- Admin -> Can be created by superadmin, by going to 'see all member' and 'create new'. Also admin can create admins/users and delete them. Also, superadmin won't be able to delete other superadmin.
- Also, admins and superadmins can create cars, delete, edit, and also create reservations on behalf of customer, on behalf of themselves, etc. They can even see checkout history of users and cars.
- User -> Can create reservations, delete, edit them. Edit their own profile and see checkout history. Also can check-out and return cars.
- Admin and super admin can also create reservations/cars and delete them. When a reservation is deleted, the car status is changed to available. Also, when a car is deleted, its associated reservations are deleted.
- Rentals are visible along with reservations. Also, on user checkout history page they are visible. If admin/superadmin sees a user, then on their show page, checkout history as well as rental is availale.

### Bonus Task

- User can suggest car

### Testing

Reservation model and controller tested using custom unit tests.

### Deployment

Heroku : swiftcar.herokuapp.com