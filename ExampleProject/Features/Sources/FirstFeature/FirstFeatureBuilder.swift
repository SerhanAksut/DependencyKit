
import FeatureInterface
import UIKit

public struct FirstFeatureBuilder: FirstFeatureBuilderProtocol {
    
    public init() {}
    
    public func build() -> UIViewController {
        let controller = FirstFeatureViewController()
        return controller
    }
}
