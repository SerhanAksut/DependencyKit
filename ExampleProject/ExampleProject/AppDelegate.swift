
import FeatureStore
import FirstFeature
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FeatureStore.shared.registerFeatures()
        buildWindowRoot()
        return true
    }
    
    func buildWindowRoot() {
        let rootController = FeatureStore.shared.firstFeature.build()
        window = UIWindow()
        window?.backgroundColor = .black
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}
