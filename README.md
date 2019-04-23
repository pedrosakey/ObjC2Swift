# GifMaker Swift 5 

![Platform iOS](https://img.shields.io/badge/migration-iOS-purple.svg)

An example of migration of an app written in objective C to swift. This is part of the course [Objective-C for Swift Developers](https://eu.udacity.com/course/objective-c-for-swift-developers--ud1009) in [Udacity](https://eu.udacity.com/) working with **Swift 5**

## Overview

GifMaker is an app that lets users create simple GIF animations from their iOS device. It is used as an example throughout Udacity's Objective-C for Swift Developers course.

## In progress


#### Create an Action Sheet

- [x] We add an action sheet as a part of View Controller 
        _TODO_ Do the same as Generic and paste in snippets library
- [x] Add launch method to photolibrar. Is not included in this section

![Action Sheet](https://drive.google.com/uc?id=1Vn1WLDRIWOYBV_G-zMGkHpMiMT349Bga)



### Share the GIF
- [x] Add the Gif to an activity items array
- [x] Present an Activity View Controller

![Share gif](https://drive.google.com/uc?id=1Vl0AxhgAM7j1y8gXfh33H3XxE3yew6hf)

**warning** is not sharing gif file properly with all apps. For example gmail app

### Add caption

- [x] Rewrite the Gif class
- [x] UITextFieldDelegate Methods
- [x] keyboard notifications and adjustment methods could be implemented in Swift.
- [x] Add a caption to the animated GIF
- [x] Show add caption in GifPreview Controller

![Add Caption](https://drive.google.com/uc?id=1VkoLlZDKJTQQb8458eMumsMMkbUMzI49)

### Convert a new recordly video into a gift
#### Present a camera
- [x] Add controllers
- [x] Compare code in objC version and swift version. Find by elements.
- [x] Swift elements in swift 3 deprecreated. We must update
- [x] I had to add Privacy Photo Additions Usage description

#### Gift conversion
- [x] Using Gifs in UIImageview we need an extension we are going to use this one:
[SwiftGif](https://github.com/swiftgif/SwiftGif)

- [X] Implement Regif methods Conversion video to Gif
[Regif](https://github.com/matthewpalmer/Regift)

- [X] Display the gif in gif editor

![Convert video into Gif](https://drive.google.com/uc?id=1VeDea0N8Jyt5vPHSBh_lw5iNheEnRq3s)


## License
   MIT
