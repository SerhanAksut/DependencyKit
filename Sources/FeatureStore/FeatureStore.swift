
public final class FeatureStore {
    public static let shared = FeatureStore()
    
    private var factories: [String: Any] = [:]
    
    private func key<Feature>(_ type: Feature.Type) -> String {
        String(reflecting: type)
    }
    
    public func register<Feature>(_ type: Feature.Type, factory: @escaping () -> Feature?) {
        factories[key(type)] = factory
    }
    
    public func unregister<Feature>(_ type: Feature.Type) {
        factories[key(type)] = nil
    }
    
    public func resolve<Feature>(_ type: Feature.Type) -> Feature? {
        guard let factory = factories[key(type)] as? () -> Feature? else {
            return nil
        }
        return factory()
    }
}
