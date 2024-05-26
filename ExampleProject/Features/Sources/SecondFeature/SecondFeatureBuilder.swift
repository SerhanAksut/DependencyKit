
import FeatureInterface
import UIKit

public struct SecondFeatureBuilder: SecondFeatureBuilderProtocol {
    
    public init() {}
    
    public func build(delegate: SecondFeatureCloseButtonDelegate) -> UIViewController {
        let controller = SecondFeatureViewController(delegate: delegate)
        return controller
    }
}
