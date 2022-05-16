# Rolodex
Employee catalogue app 🤠

| | | |
| ---- | ----- | ---- |
| ![Simulator Screen Shot - iPhone 11 - 2022-05-12 at 23 12 31](https://user-images.githubusercontent.com/22358682/168204121-ebd7af5d-352f-45e9-b677-7cac66560900.png) | ![Simulator Screen Shot - iPhone 11 - 2022-05-12 at 23 12 36](https://user-images.githubusercontent.com/22358682/168204124-062b938a-d3b3-4ede-b9fc-92f8af912e85.png) | ![Simulator Screen Shot - iPhone 11 - 2022-05-12 at 23 12 40](https://user-images.githubusercontent.com/22358682/168204122-b5b86a51-7a1c-43db-95b6-934eb4c2af12.png) |
| ![Simulator Screen Shot - iPhone 11 - 2022-05-13 at 13 52 36](https://user-images.githubusercontent.com/22358682/168340360-3914fa0f-d1b2-4a11-9557-b7acea88bccc.png) | ![Simulator Screen Shot - iPhone 11 - 2022-05-13 at 13 52 56](https://user-images.githubusercontent.com/22358682/168340361-205a5831-01e7-4346-a0f5-9570ac4184f1.png) | ![Simulator Screen Shot - iPhone 11 - 2022-05-13 at 13 53 12](https://user-images.githubusercontent.com/22358682/168340362-954f86b0-e54e-4d31-9fd4-41be4129d899.png) |

## Build tools & versions used

Built in Xcode 13.2 using Swift 5 + UIKit

## Steps to run the app

Open `Rolodex.xcodeproj`, let Swift Package Manager install the Alamofire dependency, and run! 

iOS 15.2 deployment target is set.

## What areas of the app did you focus on?

I focused on building a simple, clean, and Apple-esque, UI. This includes color-coded teams, and basic list sorting.

I also spent some time thinking about managing the state of the list, between loading, loaded, and errors. I ended up using a generic enum to represent this state (see `TableViewState.swift`), and built the table view rendering logic in the `render()` method. This is a new approach for me, and still quite vanilla architecture, but I think it worked well for the requirements of this project!

## What was the reason for your focus? What problems were you trying to solve?

The project requirements had a strong emphasis on handling various loading / error / empty state. State management is also (arguably) the most complex part of mobile app development, so, as the app grows in requirements, it should be an important focus. 

## How long did you spend on this project?

Roughly ~6 hours total.

## Did you make any trade-offs for this project? What would you have done differently with more time?

With more time, I likely would've built a super lightweight and testable image loading and caching solution. Though, with the specified time constraints, I opted to use a tried and true Swift Package instead.

## What do you think is the weakest part of your project?

I worry that my state management technique (`TableViewState`) may not scale well when additional complexity is introduced (i.e. filtering / searching). 

## Did you copy any code or dependencies? Please make sure to attribute them here!

1. I used the [AlamofireImage](https://github.com/Alamofire/AlamofireImage) library (via SPM) for image fetching and caching. It provides a very convenient helper on `UIImageView`, `.af.setImage`, which takes an image URL, placeholder image, cache key, and optional "filter". In my case, I applied a `CircleFilter()` to the image in order to have the avatars displayed as circles. This dependency is slightly "heavy" for a project like this, but for the sake of not reinventing the wheel it seemed like a worthwhile compromise.
2. I copied a property wrapper `@UseAutoLayout` from https://github.com/bielikb/UseAutoLayout. This is mostly a quality of life improvement to never type `view.translatesAutoresizingMaskIntoConstraints = false` again 😅

## Is there any other information you’d like us to know?

I'm quite pleased with how this turned out - would really appreciate any feedback :)

- Mat Schmid, [@schmidyy](https://github.com/schmidyy) on Github, [matschmidy@gmail.com](mailto://matschmidy@gmail.com)