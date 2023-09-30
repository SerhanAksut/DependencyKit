
public final class FeatureStore {
    public static let shared = FeatureStore()
    
    private var features: [String: Any] = [:]
    
    private func key<Feature>(_ type: Feature.Type) -> String {
        String(reflecting: type)
    }
    
    public func register<Feature>(_ type: Feature.Type, feature: @escaping () -> Feature?) {
        features[key(type)] = feature
    }
    
    public func unregister<Feature>(_ type: Feature.Type) {
        features[key(type)] = nil
    }
    
    public func resolve<Feature>(_ type: Feature.Type) -> Feature? {
        guard let feature = features[key(type)] as? () -> Feature? else {
            return nil
        }
        return feature()
    }
}
