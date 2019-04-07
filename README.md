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

* User can log in as user/owner
* User logs in to access subscriptions and preferences
* Search feature
* Google map implementation
* Truck Susbription
* List view and map view for taco trucks found
* Profile pages for each user

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

## Schema 
### Models
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | UserId        | Number   | unique id for the users |
   | username      | String   | User identifiers |
   | userType      | Number   | Differentiates user as a normal user or truck owner |
   | location      | GeoCoordinate| Geographical location of truck to place pin on map |
   | description   | String   | Description of truck |
   | Menu          | String   | Trucks available menu |
   | Favorites     | String   | List of users favorite trucks|
   
### Networking
#### List of network requests by screen  --> TO DO --> DELETE WHEN FINISHED
   - Home Feed Screen
      - (Read/GET) Query all posts where user is author
         ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
      - (Create/POST) Create a new like on a post
      - (Delete) Delete existing like
      - (Create/POST) Create a new comment on a post
      - (Delete) Delete existing comment
   - Create Post Screen
      - (Create/POST) Create a new post object
   - Profile Screen
      - (Read/GET) Query logged in user object
      - (Update/PUT) Update user profile image
      
      **** UPDATE MILESTONES **** DELETE THIS WHEN FINISHED
