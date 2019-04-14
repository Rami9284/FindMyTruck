# FindMyTruck
Unit 8: Group Milestone

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)

## Overview
### Description
Allow food truck owners to broadcast their location and notify subscribers that they are open. Allow users to search trucks in their area.

### App Evaluation
- **Category:** Social Networking / Food
- **Mobile:** This app would be primarily developed for IOS mobile.
- **Story:** Allow users to find taco trucks in their area(Monterey County).
- **Market:** Any individual could choose to use this app.
- **Habit:** This app could be used as often or unoften as the user wanted tacos from a taco truck.
- **Scope:** Display a map with available taco trucks in the area.

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [ ] User can log in as user/owner
- [ ] User logs in to access subscriptions and preferences
- [ ] Search feature
- [ ] Google map implementation
- [ ] Truck Susbription
- [ ] List view and map view for taco trucks found
- [ ] Profile pages for each user

**Optional Nice-to-have Stories**

* Push notification
* Option to change language 
* Ratings
* Pre-orders

### 2. Screen Archetypes

* Login - Not required but important for: 
  * Subscribtions
  * Save Preferences
* Register - User signs up or logs into their account
  * Option to select if user/truck owner
* Main Screen (Map) - User has ability to see pin locations of trucks nearby.
* Main Screen (List View) - User has ability to see a list view of trucks nearby.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Taco view preference
* Profile
* Log out
* Set location/time (for truck owner user)

**Flow Navigation** (Screen to Screen) (TBD)
* Map -> Shows taco open truck locations.
         -> Search -> Search for a specific truck by name.
         -> Filter -> Filter results with a specific criteria.
         
* List view -> Show list of open taco trucks.

* Login/Logout -> If not logged in gives option to login or create a new account.
                  -> Create Account -> Page that user can create a new user/truck account.
                  
* Truck Account Place Pin -> Place pin for truck location.
                             -> Add/Edit -> Add or Edit pin information.
                             
* User Account Favorites -> Add or Edit Users favorite trucks.

### [BONUS] Digital Wireframes & Mockups
<img src="https://i.imgur.com/wecjDNT.png" height=200>
###Update 4/13/19
<img src="http://g.recordit.co/72qXuWSfTU.gif">

## Schema 
### Models
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the users |
   | username      | String   | User identifiers |
   | password      | String   | Password for user |
   | email         | String   | users email |
   | userType      | String   | Differentiates user as a normal user or truck owner |
   | truckname     | String   | Unique name of truck |
   | location      | GeoPoint | Geographical location of truck to place pin on map |
   | description   | String   | Description of truck |
   | menu          | String   | Trucks available menu |
   | Favorites     | String   | List of users favorite trucks|
   
### Networking
#### List of network requests by screen
   - Home Map Screen
      - (Read/GET) Query all locations of active trucks and place pin on map.
   - Home List Screen
      - (Read/GET) Query all locations of active trucks.
   - Login Screen
      - (Read/GET) Query all users and compare input username/password.
   - Register Screen
      - (Create/POST) Create a new Truck/Basic user.
   - Truck User Description/Menu/Location
      - (Update/PUT) Update a Trucks Description/Menu/Location
   - Basic User Favorite
      - (Update/PUT) Update Users favorite list.

