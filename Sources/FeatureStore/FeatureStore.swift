
import Foundation

/// `FeatureStore` is a utility class designed to simplify feature management and navigation in iOS app development using UIKit. It provides a central repository for registering, unregistering, and resolving features, enabling efficient and organized feature handling within your application.
///
/// - Important: This class is a crucial component in managing the modular structure of your iOS application. It allows you to decouple and navigate between different features, optimizing your app's maintainability and build times.
public class FeatureStore {
    
    /// `shared` is a static property representing a shared singleton instance of the FeatureStore class, providing a central and consistent point of access
    public static let shared = FeatureStore()
    
    /// A private concurrent dispatch queue used for thread-safe operations on the `FeatureStore` class.
    ///
    /// This queue ensures that read operations, such as resolving features, can occur concurrently, while write operations, such as registering and unregistering features, are performed exclusively with synchronization barriers. It enhances thread safety and prevents concurrent access issues when managing the `features` dictionary.
    ///
    /// - Important: Avoid direct access to this queue unless necessary. It is managed internally for thread safety within the `FeatureStore` class.
    private let queue = DispatchQueue(label: "dependencykit.features.queue", attributes: .concurrent)
    
    /// The `features` property is a dictionary that serves as the internal storage for registered features. It uses the generated names by reflection of the features as keys and corresponding creation functions as values.
    private var features: [String: Any] = [:]
    
    /// Generates a unique key for the given Swift type.
    /// - Parameter type: The Swift type for which the key is generated.
    /// - Returns: A string representing the unique key.
    ///
    /// This function is used internally for feature registration and resolution, generating keys based on the provided Swift type.
    private func key<Feature>(_ type: Feature.Type) -> String {
        String(reflecting: type)
    }
    
    /// Registers a feature with `FeatureStore` in a thread-safe manner.
    ///
    /// - Parameters:
    ///   - type: The Swift type representing the feature to be registered.
    ///   - feature: A closure that creates and returns an instance of the feature.
    ///
    /// Use this function to dynamically register a feature with `FeatureStore`. Provide the Swift type of the feature and a closure that initializes and returns the feature instance when needed.
    ///
    /// This function ensures thread safety by synchronizing access to the internal `features` dictionary with a barrier, allowing concurrent read operations while exclusively performing write operations. It prevents data races and concurrent access issues when registering features.
    ///
    /// - Important: Always use this thread-safe registration method to avoid potential concurrent access problems.
    public func register<Feature>(_ type: Feature.Type, feature: @escaping () -> Feature?) {
        queue.sync(flags: .barrier) {
            features[key(type)] = feature
        }
    }
    
    /// Unregisters a previously registered feature in a thread-safe manner.
    ///
    /// - Parameter type: The Swift type representing the feature to be unregistered.
    ///
    /// Use this function to remove a feature's registration from `FeatureStore` when it is no longer needed or should be replaced with a different implementation.
    ///
    /// This function ensures thread safety by synchronizing access to the internal `features` dictionary with a barrier, allowing concurrent read operations while exclusively performing write operations. It prevents data races and concurrent access issues when unregistering features.
    ///
    /// - Important: Always use this thread-safe unregistration method to avoid potential concurrent access problems.
    public func unregister<Feature>(_ type: Feature.Type) {
        queue.sync(flags: .barrier) {
            features[key(type)] = nil
        }
    }
    
    /// Resolves and returns a registered feature in a thread-safe manner.
    ///
    /// - Parameter type: The Swift type representing the feature to be resolved.
    /// - Returns: An instance of the resolved feature or `nil` if the feature has not been registered.
    ///
    /// Use this function to access and obtain a registered feature instance with type safety. If the feature is not registered, it returns `nil`.
    ///
    /// This function ensures thread safety by synchronizing access to the internal `features` dictionary, allowing concurrent read operations. It prevents data races and concurrent access issues when resolving features.
    ///
    /// - Important: Always use this thread-safe resolution method to avoid potential concurrent access problems.
    public func resolve<Feature>(_ type: Feature.Type) -> Feature? {
        queue.sync {
            guard let feature = features[key(type)] as? () -> Feature? else {
                return nil
            }
            return feature()
        }
    }
}
