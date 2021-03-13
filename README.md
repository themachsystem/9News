# News

* The Swift 5 project that allows downloading news feed. 
* The application uses MVVM (Model-View-ViewModel) design pattern
* The app uses UIKit: storyboard and auto layout
* The app uses SDWebImage library for loading & caching Internet images.
* The automated UI tests are implemented to simulate the normal use-cases and test the behavior of the application in different scenarios.
* Unit tests are provided

### How the app behaves

* Running for the first time the app shows a loading activity indicator while performing API call to download news articles. 
* The app then lists all the downloaded news article and displays on table view 
* User can tap on an news article to see its details in the web view screen
* The app handles api call failure by showing error message and prompt to Retry.
* The app work in iPhone and iPad in all orientations.
* The app supports Dark Mode.

### Prerequisites

* XCode version: 12
* Swift version: 5
* Cocoapods version: 1.2.0
* Minimum iOS version supported: 11 

### Building

Do a pod install from the root folder, open News.xcworkspace and do a build.

### Running the tests

* The  test are run by selecting the Test Navigator tab on XCode left side panel
* When running the automated UI tests, you can see the application simulates the user interactions. 

### App screenshots
![Screenshot](/light.png) 

![Screenshot](/dark.png)

![Screenshot](/web.png)

