
import Dependencies
import UIKit

public struct SecondFeatureBuilder: SecondFeatureBuilderProtocol {
    
    public init() {}
    
    public func build(delegate: CloseButtonDelegate) -> UIViewController {
        let controller = SecondFeatureViewController(delegate: delegate)
        return controller
    }
}
