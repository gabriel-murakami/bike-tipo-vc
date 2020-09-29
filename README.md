# BIKE TIPO VC

- Link
  - https://bike-tipo-vc-gma.herokuapp.com/users/sign_in

- Ruby version
  - 2.6.2

- System dependencies 
  - Redis
  - Sidekiq

- Configuration

  ```sh
  bin/setup
  rails db:seed
  ```
- Run test suit

  ```sh
  bundle exec rspec
  ```
 
---

### Services
  - Pricing
    - BillingValueService
      > calculates total bill value
    - TripCostService
      > calculates individual trip cost
  - DevolutionService
    > manages bike devolutions
  - WithdrawService
    > manages bike withdraws

---

### Workers
  - CalculateTripCostWorker
    > triggered after bike devolution and calls TripCostService
  - SendTripToPrefectureWorker
    > triggered after trip cost calculation and sends trip data to Springfield API
  - SendBillingNotificationWorker
    > schedules billing notification after a user is created
  
---

### Mailers
  - BillingMailer
