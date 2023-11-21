# DependencyKit
 A dependency management library for Swift based projects.
 
# Introduction
DependencyKit is a Swift package library for seamless dependency management for Swift based projects. Effortlessly manage feature transitions and decouple modules, enhancing app maintainability and build efficiency. 
 
# FeatureStore - Dependency Management Library

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/SerhanAksut/DependencyKit/blob/main/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/SerhanAksut/DependencyKit.svg)](https://github.com/SerhanAksut/DependencyKit/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/SerhanAksut/DependencyKit.svg)](https://github.com/SerhanAksut/DependencyKit/network)
[![GitHub Issues](https://img.shields.io/github/issues/SerhanAksut/DependencyKit.svg)](https://github.com/SerhanAksut/DependencyKit/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/SerhanAksut/DependencyKit.svg)](https://github.com/SerhanAksut/DependencyKit/pulls)

FeatureStore is a Swift package library designed to streamline feature navigation in iOS app development. It offers an efficient method for managing and navigating between various features while optimizing `incremental build time` in your applications.

## Key Features

- **Singleton Design:** Utilize the shared instance of `FeatureStore` for consistent feature management throughout your app.

- **Dynamic Feature Registration:** `Register` features dynamically with closures, allowing for lazy instantiation when needed.

- **Feature Unregistration:** Easily `unregister` features when they are no longer required.

- **Feature Resolution:** `Resolve` and access registered features with type safety.

## Installation

You can integrate FeatureStore into your project using Swift Package Manager (SPM). Add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/SerhanAksut/DependencyKit.git", from: "1.4.0")
]
```

Then, import `FeatureStore` dependency in your Swift files where you intend to use it:

```swift
import FeatureStore
```

## Usage | UIKit & SwiftUI
To get started, follow these basic steps:

### 1. Register a Feature
```swift
FeatureStore.shared.register(MyFeatureProtocol.self) {
    MyFeature()
}
```

Here, `MyFeatureProtocol.self` is the type of your feature, and the closure is used to create an instance of that feature. Replace MyFeature with your actual feature type and provide the appropriate closure to create an instance.


### 2. Resolve a Feature
To access a registered feature, use the `resolve` method:

#### UIKit
```swift
import FeatureStore
import UIKit

public protocol MyFeatureProtocol {
    // Pass some parameters into the function if needed between features.
    func build() -> UIViewController
}

public extension FeatureStore {
    var myFeature: MyFeatureProtocol {
        resolve(MyFeatureProtocol.self)!
    }
}
```

#### SwiftUI
```swift
import FeatureStore
import SwiftUI

public protocol MyFeatureProtocol {
    // Pass some parameters into the function if needed between features.
    func build() -> AnyView
}

public extension FeatureStore {
    var myFeature: MyFeatureProtocol {
        resolve(MyFeatureProtocol.self)!
    }
}
```

Make sure to replace `MyFeature` with the actual feature type you want to resolve.

### 3. Unregister a Feature
When a feature is no longer needed, you can `unregister` it from the feature store:

```swift
FeatureStore.shared.unregister(MyFeatureProtocol.self)
```

### 4. Navigation Between Features
Let's consider a scenario where you have two different modules, `FeatureA` and `FeatureB`, which are separate Swift package libraries. You need to present FeatureB from FeatureA. Here's how you can achieve this:

Firstly, we need to register these features:

```swift
import FeatureStore
import FeatureA
import FeatureB

FeatureStore.shared.register(FeatureAProtocol.self) {
    FeatureA()
}
FeatureStore.shared.register(FeatureBProtocol.self) {
    FeatureB()
}
```

For each feature, create resolvers:

FeatureA:

#### UIKit
```swift
import FeatureStore
import UIKit

public protocol FeatureAProtocol {
    func build() -> UIViewController
}

public extension FeatureStore {
    var featureA: FeatureAProtocol {
        resolve(FeatureAProtocol.self)!
    }
}
```

#### SwiftUI
```swift
import FeatureStore
import SwiftUI

public protocol FeatureAProtocol {
    func build() -> AnyView
}

public extension FeatureStore {
    var featureA: FeatureAProtocol {
        resolve(FeatureAProtocol.self)!
    }
}
```

FeatureB:

#### UIKit
```swift
import FeatureStore
import UIKit

public protocol FeatureBProtocol {
    func build() -> UIViewController
}

public extension FeatureStore {
    var featureB: FeatureBProtocol {
        resolve(FeatureBProtocol.self)!
    }
}
```

#### SwiftUI
```swift
import FeatureStore
import SwiftUI

public protocol FeatureBProtocol {
    func build() -> AnyView
}

public extension FeatureStore {
    var featureB: FeatureBProtocol {
        resolve(FeatureBProtocol.self)!
    }
}
```

As we want to present `FeatureB` from `FeatureA`, so we will create a `public` builder in `FeatureB`:
 
#### UIKit
```swift
import FeatureStore
import UIKit

public struct FeatureBBuilder: FeatureBBuilderProtocol {
    public init() {}
    
    public func build() -> UIViewController {
        let controller = FeatureBViewController()
        // Configure your controller as needed
        return controller
    }
} 
```

#### SwiftUI
```swift
import FeatureStore
import SwiftUI

public struct FeatureBBuilder: FeatureBBuilderProtocol {
    public init() {}
    
    public func build() -> AnyView {
        let featureAView = FeatureASwiftUIView()
        // Configure your swiftUI view as needed
        return AnyView(featureAView)
    }
} 
```

Finally, we just need to build featureB from featureA and navigate to featureB:

#### UIKit
```swift
let controller = FeatureStore.shared.featureB.build()
present(controller, animated: true)
```

#### SwiftUI
```swift
var body: some View {
    NavigationStack {
        NavigationLink("Show FeatureB Screen") {
            FeatureStore.shared.featureB.build()
        }
    }
}
```

## Support
If you have any questions, encounter issues, or want to contribute, please [create an issue](https://github.com/SerhanAksut/DependencyKit/issues) or [submit a pull request](https://github.com/SerhanAksut/DependencyKit/pulls) on GitHub.
