# Swift Car

### CSC/ECE 517 (OO Design and Development)

#### Following is the requirement file along with the implementation details .

You are tasked with creating a car-rental app.

    There can be multiple cars with the same model and manufacturer.

    The status of a car in the system may have one of the three values :

        “reserved”

        “checked out”

        “available”

     <span style="color:blue">A user can reserve a car or rent a car without a previous reservation. A user is not allowed to have more than one car rented at a time. Only after canceling a reservation or returning a rented car, can a user can reserve or rent another car.</span>

    The reservation process is automatic, and does not require an admin to approve requests. If the status of a car is “available” and a user rents it, the status of that car immediately transitions to “reserved”. But an admin can edit the reservation later.

    When a reservation is made, it must specify the time that the car is to be picked up (“checked out”) and returned. In order to simulate checkout and returns actions in the real world, there should be buttons that a user can manually click to indicate that a car has been checked out or returned.

    The minimum rental period is 1 hour and the maximum is 10 hours. The system should cancel a reservation if a user doesn’t check out a car in time. The time elasticity is 30 minutes after the pickup time.  For example, if a user reserved a car to pick up at 3:00pm, if the car was not checked out by 3:31pm, then the car should become “available” again.

    If a user doesn’t return a car on the date promised when it was checked out, the system will sent a notification (e.g. system message) to the user and automatically change the car status to “available”.


There will be three types of users in the system:

    Superadmin

    Admin

    User

Superadmin

The system should have a preconfigured admin (superadmin). A superadmin should be capable of performing all operations performed by an Admin (listed below) and should also be able to manage admins (e.g. to delete other admins).

Superadmins should be able to

        Create new superadmins

        View the list of superadmins and their profile details (except password)

        Should not be able to delete other superadmins.


Admin

An admin user will have the following attributes: email (unique for each admin), name and password.

All admins can perform the following tasks:

    Log in with an email and password

    Edit their own profile

    Manage admins

        Create new admins

        View the list of all the admins and their profile details (except password)

        Delete admins (except themselves and the superadmins)

    Manage Cars

        Add a Car to the system. A Car will have the following attributes:

            License-plate number (a 7-digit string unique for each Car)

            Manufacturer

            Model (String  … this app doesn’t need to validate that the model is actually produced by the indicated manufacturer.)

            Hourly Rental rate

            Style (Coupe, Sedan or SUV)

            Location (office where the car can be picked up)

            Status to indicate availability:

                Checked out - when a customer checks out the car or an admin checks out the car on behalf of a customer

                Available - otherwise

        View the list of all Cars

        View the attributes of a Car. Also, show the user who has the car if its status is “Checked out” or “Reserved”.

        Edit the attributes of a Car

            An admin can also change the status of a car i.e., she/he can reserve, check out or return a car on behalf of a customer.

                When an admin reserves, checks out or returns a car on behalf of a customer, the information captured in your database should be the same as if the car was reserved or checked out by a customer..

            An admin can edit a reservation on behalf of a customer.

        View the checkout history of a car.

        Delete a car from the system

    Manage customers

        List all customers and profile attributes (except password), with an option to edit a particular customer

        View the checkout history of a customer

        Delete a customer

Customers

A customer will have the following attributes: email (unique for each member), name and password and rental charge. The rental charge is computed from (rental rate ✕ the number of hours the customer held the car)

Anyone can sign up as a customer using their email, name and password. After signup, they can perform the following tasks:

    Log in with email and password

    Edit their own profile

    Search cars using location or model or manufacturer or style or status

        search results should be a list of cars matching the search criteria

    View the attributes of a car

    Reserve or check out a car if its status is “Available”, and, as part of both operations, specify a return time car.

    Return a checked-out car

    View their own checkout history

Miscellaneous
Testing

    Thoroughly test one Model and one Controller. Feel free to use any testing framework.

### Deployment

Heroku or any similar PaaS (OpenShift etc) with free plans
Amazon AWS
