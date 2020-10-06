# SchafKit

**WARNING**: The documentation is out of sync with the code.
Since we forked OpenKit, we've changed a lot and didn't update the documentation to reflect that yet.

An open kit providing useful functions across iOS, watchOS, macOS and tvOS, taking advantage of Swifts rich feature set.

OpenKit contains eight major components. To make these more comprehensible, each of them has its own documentation section, which is linked to in the sections below.
There is also a section for custom iOS UI and one for all Extensions.

- [Features](#features)
   - [Components](#components)
      - [Appearance (iOS only)](#appearance)
      - [Cryptography](#cryptography)
      - [Dispatch](#dispatch)
      - [File System](#file-system)
      - [JSON](#json)
      - [Networking](#networking)
      - [Options](#options)
      - [RegEx](#regex)
      - [Settings (iOS only)](#settings)
   - [Custom iOS UI](#custom-ios-ui)
   - [Extensions](#extensions)
-  [Installation](#installation)
-  [To-Do](#to-do)

# Features

## Components

### Appearance
###### iOS only
Appearance provides a standardized way to customize the appearance of applications. Handling most tasks automatically, notifying objects when the appearance style or system font size changes and providing easy ways to access these. It is highly customizable and has three default appearance styles: light (standard iOS), dark and black.

Documentation

### Cryptography
`OKCryptography` is a wrapper around TweetNacl, providing the `Curve25519XSalsa20Poly1305BoxAlgorithm`, `XSalsa20Poly1305SecretBoxAlgorithm` and `Ed25519Algorithm` classes.

Documentation

### Dispatch
`OKDispatchHelper` helps submitting blocks to dispatch queues.

```swift
OKDispatchHelper.dispatch(on: .main,
                          block: {
   // Do something here
})
```

Documentation

### File System
`OKFileSystemItem` and its subclasses `OKFile` and `OKDirectory` provide easy access to the File System.

Documentation

### Networking
Networking offers an easy way to send simple or advanced network requests.

Simple:
```swift
OKNetworking.request(url: "https://github.com/JannThomas/OpenKit",
                     completion: { (result, error) -> Void in 
    // Do something here
})
```

Advanced:
```swift
let block : OKNetworking.RequestCompletionBlock = { (result, error) -> Void in 
    // Do something here, for example: result.jsonValue?["Test"]["Toast"]
}

let headerFields : [OKNetworking.Request.HeaderField: String] = [.accept : "*/*",
                                                                 "CustomField" : "CustomValue"]

OKNetworking.request(url: "https://github.com/JannThomas/OpenKit",
                     options: [.requestMethod(value: .post), 
                               .headerFields(value: headerFields), 
                               .body(value: .xWwwFormUrlencoded(value: ["Key" : "Value"]))],
                     completion: block)
```

Documentation

### Settings
###### iOS only
Settings manages, stores and displays settings in a standardized way that resembles Apple's Settings. It's also highly customizable. Completely custom UI is implementable.

Documentation

### RegEx
`OKRegexMatch` handles regular expressions.

```swift
guard let matches = "Test".regexMatches(with: "(T)est") else {
   return
}

print(matches.first?.captureGroups.first) // "T"
```

Documentation

## Custom iOS UI
| ![](http://jannthomas.com/OpenKit/Resources/iOS/OKLoadingIndicator.gif) | ![](http://jannthomas.com/OpenKit/Resources/iOS/OKRefreshControl.gif) |
| :---: | :---: |
| OKLoadingIndicator | OKRefreshControl |


| ![](http://jannthomas.com/OpenKit/Resources/iOS/popover1.png) | ![](http://jannthomas.com/OpenKit/Resources/iOS/popover2.png) | ![](http://jannthomas.com/OpenKit/Resources/iOS/popover3.png) |
| :---: | :---: | :---: |
| [OKTimeIntervalChooserViewController]() (mode: .date) in [OKSegmentedViewController]() in [OKPopoverController]() | [OKTimeIntervalChooserViewController]() (mode: .timeInterval) in [OKSegmentedViewController]() in [OKPopoverController]() | [OKTimeIntervalChooserViewController]() (mode: .timeInDay) in [OKBottomSheetPopoverController]() |

## Extensions

A big part of `OpenKit` are extensions. You can find all of them in the documentation, but here are the most important ones with examples.

# Installation

### Swift Package Manager

OpenKit relies on Swift Package Manager and is installed by adding a

# To-Do
- [ ] Fix watchOS XCTest Error
- [ ] Implement OKFile
- [ ] Introduce a ```JSDateTimeHelper``` class, which contains, for example, something like ```String.extractedSeconds```
- [ ] Make platform exclusive features available to other platforms (specifically [Settings](#settings))
- [ ] Uploading in [Networking](#networking)
