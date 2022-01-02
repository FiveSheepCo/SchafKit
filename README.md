# SchafKit

[![GithubCI_Status]][GithubCI_URL] [![LICENSE_BADGE]][LICENSE_URL]

Up to date documentation can be found at: [SchafKit Wiki](https://github.com/Quintschaf/SchafKit/wiki)

A kit providing useful functions across iOS, watchOS, macOS and tvOS, taking advantage of Swifts rich feature set.

- [Features](#features)
   - [Components](#components)
      - [Cryptography](#cryptography)
      - [Dispatch](#dispatch)
      - [File System](#file-system)
      - [Networking](#networking)
      - [RegEx](#regex)
   - [Extensions](#extensions)
-  [License](#license)
-  [Installation](#installation)
-  [To-Do](#to-do)

# Features

## Components

### Cryptography
`SKCryptography` is a wrapper around TweetNacl, providing the `Curve25519XSalsa20Poly1305BoxAlgorithm`, `XSalsa20Poly1305SecretBoxAlgorithm` and `Ed25519Algorithm` classes.

### Dispatch
`SKDispatchHelper` helps submitting blocks to dispatch queues.

```swift
SKDispatchHelper.dispatch(
    on: .main,
    block: {
   // Do something here
})
```

### File System
`SKFileSystemItem` and its subclasses `SKFile` and `SKDirectory` provide easy access to the File System.

### Networking
Networking offers an easy way to send simple or advanced network requests. The examples below use Swift 5.5's `await`. Everything is also possible to use with a callback.

Simple:
```swift
do {
    let result = try await SKNetworking.request(
        url: "https://github.com/Quintschaf/SchafKit"
    )
    
    print(result.stringValue) // Prints the html received
}

```

Advanced:
```swift
let block : SKNetworking.RequestCompletionBlock = { (result, error) -> Void in 
    // Do something here, for example: result.jsonValue?["Test"]["Toast"]
}

let headerFields : [SKNetworking.Request.HeaderField: String] = [
    .accept : "*/*",
    "CustomField" : "CustomValue"
]

let result = SKNetworking.request(
    url: "https://github.com/JannThomas/OpenKit",
    options: [
        .requestMethod(value: .post), 
        .headerFields(value: headerFields), 
        .body(value: .xWwwFormUrlencoded(value: ["Key" : "Value"]))
    ]
)

// Do something with the result
```

### RegEx
`SKRegexMatch` handles regular expressions.

```swift
guard let matches = "Test".regexMatches(with: "(T)est") else {
   return
}

print(matches.first?.captureGroups.first) // "T"
```

## Extensions

A big part of `SchafKit` are extensions. You can find all of them in the documentation, but here are the most important ones with examples.

### `String`

#### Static Variables
| Variable         | Return Type | Description                                                                 | Result                         |
|------------------|-------------|-----------------------------------------------------------------------------|--------------------------------|
| empty            | String      | An empty string.                                                            | ""                             |
| space            | String      | A string containing a space character.                                      | " "                            |
| newline          | String      | A string containing a newline character.                                    | "\n"                           |
| tab              | String      | A string containing a tab character.                                        | "\t"                           |

#### Variables
| Variable         | Return Type | Description                                                                 | Example                                   | Result                         |
|------------------|-------------|-----------------------------------------------------------------------------|-------------------------------------------|--------------------------------|
| localized        | String      | A localized version of the receiver.                                        | "DONE_BUTTON_TEXT".localized              | "Done"                         |
| urlEncoded       | String      | A URL-encoded version of the receiver.                                      | "https://quintschaf.com".urlEncoded       | "https%3A%2F%2Fquintschaf.com" |
| urlDecoded       | String      | A URL-decoded version of the receiver.                                      | "https%3A%2F%2Fquintschaf.com".urlDecoded | "https://quintschaf.com"       |
| extractedSeconds | Int?        | Extracts number of seconds from the receiver in a hh:mm:ss/mm:ss/ss format. | "00:02:15".extractedSeconds               | 135                            |

SchafKit also included sane subscripts for Strings, making syntax like `"abc"[0...1]` possible.

# Installation

### Swift Package Manager

SchafKit relies on Swift Package Manager and is installed by adding it as a dependency.

# License

We have chosen to use the CC0 1.0 Universal license for SchafKit. The following short explanation has no legal implication whatsoever and does not override the license in any way: CC0 1.0 Universal license gives you the right to use or modify all of SchafKits code in any (commercial or non-commercial) product without mentioning, licensing or other headaches of any kind.

# To-Do
- [ ] Implement SKFile
- [ ] Uploading in [Networking](#networking)
- [ ] More Extension Examples in README
- [ ] Full Documentation
    - [ ] `SKAlerting`
    - [ ] `SKStoreKitHelper`
    - [ ] `SKJsonRepresentable`
    - [ ] Custom SwiftUI components

<!-- References -->

[GithubCI_Status]: https://github.com/Quintschaf/SchafKit/actions/workflows/swift.yml/badge.svg?branch=master
[GithubCI_URL]: https://github.com/Quintschaf/SchafKit/actions/workflows/swift.yml
[LICENSE_BADGE]: https://badgen.net/github/license/quintschaf/SchafKit
[LICENSE_URL]: https://github.com/Quintschaf/SchafKit/blob/master/LICENSE
