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

I researched and found multiple publically API avilable but this is the only one that is the closest vs FaceBook or Instagram

Documentation for the Random User Generator API
https://randomuser.me/documentation

This is a sample JSON file

```json

{ 
   "results":[ 
      { 
         "gender":"male",
         "name":{ 
            "title":"mr",
            "first":"clésio",
            "last":"pereira"
         },
         "location":{ 
            "street":"888 rua vinte e dois ",
            "city":"muriaé",
            "state":"tocantins",
            "postcode":29620,
            "coordinates":{ 
               "latitude":"-73.0778",
               "longitude":"-86.9292"
            },
            "timezone":{ 
               "offset":"+9:00",
               "description":"Tokyo, Seoul, Osaka, Sapporo, Yakutsk"
            }
         },
         "email":"clésio.pereira@example.com",
         "login":{ 
            "uuid":"3be1e9f3-7252-4c50-969c-071fab797cfa",
            "username":"purplerabbit124",
            "password":"gone",
            "salt":"BkukXtaf",
            "md5":"a35a898ccf9adc55a422e66422e3e928",
            "sha1":"38cfd210e27fc7b5e7010ca0c9abb1903e5fe899",
            "sha256":"9b3e7743cbaeee069329834704ac05bb614d83d45d78b2d435be7d1fd63bb736"
         },
         "dob":{ 
            "date":"1970-10-30T11:48:13Z",
            "age":48
         },
         "registered":{ 
            "date":"2003-12-13T20:27:13Z",
            "age":15
         },
         "phone":"(67) 4648-9696",
         "cell":"(15) 5516-3313",
         "id":{ 
            "name":"",
            "value":null
         },
         "picture":{ 
            "large":"https://randomuser.me/api/portraits/men/96.jpg",
            "medium":"https://randomuser.me/api/portraits/med/men/96.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/men/96.jpg"
         },
         "nat":"BR"
      }
   ],
   "info":{ 
      "seed":"ed3560a239961014",
      "results":1,
      "page":1,
      "version":"1.2"
   }
}
```