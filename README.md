# **Uber Clone App**

## ***Abstract***

_A customer requests a pick up at a location chosen by the customer. The pickup order is dispatched to drivers who are available within an area of reach. One of the drivers picks up the customer's request and proceeds to the customer's location for a pick up. Once the pick-up takes place, the driver will transport the customer to a destination chosen by the customer. Customer pay some amount and can give ratings to the driver._

## ***We will be going to extend Travelling experience with following app Features***


- ###### Customer registration 

Customer/rider downloads the Uber rider app. Customer registration done by verifying customer's credentials(phone number). We store customer's information in our firestore backend. The credentials are used to authenticate customer's order request and present to assigned drivers. 

- ###### Driver registration 

The driver downloads the Uber driver app, registers and authenticates through mobile number. Some of these credentials with vehicle data presented to the rider. 

 

- ###### Identify drivers 

In order to provide a great travelling experience for customers, The driver's name and vehicle information will be shown to nearby customer. 

For example, the device name can be a driver's name or some other identifier you use in your system with example below: 
```
{ 

  "driver_name": "Piyush Thakur", 

  "vehicle_data": { 

    "model": "i3", 

    "comapny": "BMW", 

    "color": "white", 

    "num_plate":"GJ6-2834" 

  } 

} 
```
- ###### Locate nearby drivers 

Live location is an important input to the app. As soon as the driver presses “online” button , app exposes the location  to nearby rider. Rider can locate the driver’s location as soon as he request that driver for booking. 

- ###### Assign and accept order 

Once nearby available drivers located, rider’s request is assigned to available drivers and presented in their driver app. One of the drivers can accept the order and drive to the pickup location. 

- ###### Assign order request to available drivers 

Rider assigns order request to the nearest available drivers. Driver app presents the pickup order in the screen to each of these available drivers, along with the customer name and pickup location.  

- ###### Driver acceptance 

As illustrated in the image above, driver app gives an opportunity for the driver to accept an assigned order. Once the driver accepts the order by clicking “Accept  ” button then only location and rider info is shared and driver will drive to pick-up point. 

- ###### Track driver to customer pickup location 

Once the driver accepted the pickup order, google map will show the path to driver to the destination at pickup location and provide a real-time tracking experience to the customer/rider. 

- ###### Generate trip summary 

Once the order to the drop off destination is complete, firebase backend generates a trip summary that can be shared with both rider and driver. 

- ###### Payment and Review 

Once the order to the drop off destination is complete, rider is able to share their experience as ratings and able pay amount with multiple options such as cash, UPI payment, credit/debit card etc. 

- ###### Ensuring payment 

Driver confirms the payment of the rider at the end of the trip by clicking the “payment accepted” button at driver’s app. 

- ###### Ratings and Journey 

Rider can give ratings to driver after completing the trip & according to the travel experience he can share his comments. 

Trip history will remain as summary for both rider and driver apps. 

<a href="https://github.com/zalakuldip740/Uber_Clone/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=zalakuldip740/Uber_Clone" />
</a>

Made with [radixweb](https://github.com/zalakuldip740/Uber_Clone).
