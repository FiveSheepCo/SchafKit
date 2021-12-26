# SchafKit

**WARNING**: The documentation is out of sync with the code.
Since we forked OpenKit, we've changed a lot and didn't update the documentation to reflect that yet.

Up to date documentation can be found at: [SchafKit Wiki](https://github.com/Quintschaf/SchafKit/wiki)

An open kit providing useful functions across iOS, watchOS, macOS and tvOS, taking advantage of Swifts rich feature set.

OpenKit contains eight major components. To make these more comprehensible, each of them has its own documentation section, which is linked to in the sections below.
There is also a section for custom iOS UI and one for all Extensions.

- [Features](#features)
   - [Components](#components)
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

### Cryptography
`SKCryptography` is a wrapper around TweetNacl, providing the `Curve25519XSalsa20Poly1305BoxAlgorithm`, `XSalsa20Poly1305SecretBoxAlgorithm` and `Ed25519Algorithm` classes.

Documentation

### Dispatch
`SKDispatchHelper` helps submitting blocks to dispatch queues.

```swift
SKDispatchHelper.dispatch(on: .main,
                          block: {
   // Do something here
})
```

Documentation

### File System
`SKFileSystemItem` and its subclasses `SKFile` and `SKDirectory` provide easy access to the File System.

Documentation

### Networking
Networking offers an easy way to send simple or advanced network requests.

Simple:
```swift
SKNetworking.request(url: "https://github.com/Quintschaf/SchafKit",
                     completion: { (result, error) -> Void in 
    // Do something here
})
```

Advanced:
```swift
let block : SKNetworking.RequestCompletionBlock = { (result, error) -> Void in 
    // Do something here, for example: result.jsonValue?["Test"]["Toast"]
}

let headerFields : [SKNetworking.Request.HeaderField: String] = [.accept : "*/*",
                                                                 "CustomField" : "CustomValue"]

SKNetworking.request(url: "https://github.com/JannThomas/OpenKit",
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
`SKRegexMatch` handles regular expressions.

```swift
guard let matches = "Test".regexMatches(with: "(T)est") else {
   return
}

print(matches.first?.captureGroups.first) // "T"
```

Documentation

## Extensions

A big part of `SchafKit` are extensions. You can find all of them in the documentation, but here are the most important ones with examples.

# Installation

### Swift Package Manager

SchafKit relies on Swift Package Manager and is installed by adding it as a dependency.

# To-Do
- [ ] Implement SKFile
- [ ] Uploading in [Networking](#networking)
