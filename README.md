# Hello Asso


iOS HelloAsso technical test.

## Launching the project

The code is on my github in public at this url :

[Source code](https://github.com/pierre-marie/helloAsso.git)


### Prerequisites

You will need to install the dependencies by running the following command in the project directory.

```
pod install
```

After that you will be able to open the helloAsso.xcworkspace file with Xcode.

## Targets

The project as two targets :

* helloAsso (main target)
* helloAssoTests (test target)

## Pods

This project use the following Pods

* RxSwift (reactive swift programming)
* Alamofire (networking)
* SpotifyLogin (helper to login to spotify)
* Unbox (mapping)
* RxCocoa (RxSwift companion)

## Architecture

The project is organised with a MVVM architecture.
Each fonctionnal block is in a directory containing :

* Mock (mock files for testing)
* Data (the data layer)
* ViewModel (the logic)
* View (the views)

