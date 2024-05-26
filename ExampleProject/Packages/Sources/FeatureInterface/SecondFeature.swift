
import FeatureStore
import UIKit

public protocol SecondFeatureCloseButtonDelegate: AnyObject {
    func didTapCloseButton(on controller: UIViewController)
}

public protocol SecondFeatureBuilderProtocol {
    func build(delegate: SecondFeatureCloseButtonDelegate) -> UIViewController
}

public extension FeatureStore {
    var secondFeature: SecondFeatureBuilderProtocol {
        resolve(SecondFeatureBuilderProtocol.self)!
    }
}
