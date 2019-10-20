ME Bank
============

# Tasks Completed

Tasks worked on:

- Create a completly fresh empty project
- Integrate Quick and Nimble using built in Swift Package Manager in Xcode 11
- Architect and implement the app using clean MVVM Design Pattern with Swift 5.0
- Structure the application code folders
- Decode and map modles using Codable
- Simplify API End Point 
- Implement a Generic API Manager to handle any endpoint
- Create a specific API client to retrieve users which inherits from API Manager
- Create custom cells to display the data
- Add a number of extentions including elegant ways to register for TableViewCells and many other features.
- Add Theme pattern
- Added error handling using within one generic function to reduce amount of code
- Add Localized file
- Add unit tests using Quick and Nimble

# Additonal UI Features

The Following are new features developed:

- Create ME Bank icon for the App
- Implement a foldable UITableViewCell
- Avoided using 3rd party libraries with the exception of only Quick and Nimble for unit testing, hence a number of quality clean extentions are included.  (Almofire is too bulky for this)
- FoldingCell class is from Github but I changed how it gets used.


Please Note:
- Implemented using Xcode Version Version 11.1 (11A1027) and Swift 5.0.
- I have used Carthage and CocoPods in many projects in the past but I decided to try out the native Swift Package Manager, please refer to other code challenges on my github if required.
- The App fetches data from a publically avilable API that I discovered in order to memic the RAML script which I didn't have access to as it wasn't properlly attached in the email.
- The dates and pics of the random users getting displayed are correct but the public API uses crazy dates for date of birth as well as may use the same pics to different users.
================

