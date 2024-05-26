
import FeatureStore
import UIKit

public protocol FirstFeatureBuilderProtocol {
    func build() -> UIViewController
}

public extension FeatureStore {
    var firstFeature: FirstFeatureBuilderProtocol {
        resolve(FirstFeatureBuilderProtocol.self)!
    }
}
