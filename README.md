# UserPrediction

This is a package in its early state. It aims to predict users. Currently user text input is predictable.

## Installation

Install this package with the help of the Swift Package Manager. In XCode go to *File/Swift Packages/Add Package Dependency/* there, add this link: 

```HTML
https://github.com/simonloewe/UserPrediction.git
```

and then import it to your project by adding: 

```Swift
import UserPrediction
```

## Usage

Currently this packages functionality is limited to predicting strings. This can be useful to predict TextField input.

### Predicting String

Generall usage is:

```Swift
Prediction.predict(...)
```

There are several options currently available to use. They can be summarised into:

```Swift
// Searches for the input in a certain predefined searchable source
static func predict(input, in)

// Searches for the input, which is bound, in a predefined searchable source and returns it continuously via an @escaping completion for as long as a certain condition is set or at max. 60 seconds have passed
static func predictContinuous(Binding<input>, in, while, completion)
```

A full list of all awailable functions and their mutations:

```Swift
static func predict(input subItem: String, in str: String) -> String

static func predict(input subItem: String, in array: [String]) -> [String]

static func predict<T>(input subItem: String, in dictionary: Dictionary<T, String>) -> Dictionary<T, String>

static func predict<T>(input subItem: String, in dictionary: Dictionary<String, T>) -> Dictionary<String, T>

static func predictContinuous(input subItem: Binding<String>, in str: String, while condition: Bool, completion: @escaping (String) -> Void)

static func predictContinuous(input subItem: Binding<String>, in str: [String], while condition: Bool, completion: @escaping ([String]) -> Void)

static func predictContinuous<T>(input subItem: Binding<String>, in str: Dictionary<T, String>, while condition: Bool, completion: @escaping (Dictionary<T, String>) -> Void)

static func predictContinuous<T>(input subItem: Binding<String>, in str: Dictionary<String, T>, while condition: Bool, completion: @escaping (Dictionary<String, T>) -> Void)
```

## Examples of use

Some examples of usage.

### Predicting String in TextField

[TextFieldExample.swift](Sources/PredictionLibrary/Examples/StringPrediction/TextFieldExample.swift)

## Defaults

### Predicting String Defaults

There are a couple of default values active.

```Swift
// Used as percentage to correct mistakes in strings
fileprivate static var correctionPercentage: Double = 0.5

// Defines wether mistype ignorance is active or not
fileprivate static var withCorrection: Bool = true
```

These can be adjusted by overwriting them with:

```Swift
// Set new correction percentage
static func setCorrectionPercentage(new percentage: Double)

// If mistyped ignorance is active or not
static func setCorrection(new correction: Bool)
```

## TODO

- [ ] Make String prediction asynchronous
- [ ] Make String prediction more flexible
- [ ] More examples for String prediction
- [ ] Full code doc for String prediction
- [ ] Add other user predicting functions