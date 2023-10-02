
import Dependencies
import FeatureStore
import FirstFeature
import SecondFeature

struct FeatureBuilder {
    static let shared = FeatureBuilder()
    private let builder: FeatureStore
    
    init(builder: FeatureStore = .shared) {
        self.builder = builder
    }
    
    func registerFeatures() {
        builder.register(FirstFeatureBuilderProtocol.self) {
            FirstFeatureBuilder()
        }
        builder.register(SecondFeatureBuilderProtocol.self) {
            SecondFeatureBuilder()
        }
    }
}
