
import FeatureInterface
import FeatureStore
import FirstFeature
import SecondFeature

extension FeatureStore {
    func registerFeatures() {
        FeatureStore.shared.register(FirstFeatureBuilderProtocol.self) {
            FirstFeatureBuilder()
        }
        FeatureStore.shared.register(SecondFeatureBuilderProtocol.self) {
            SecondFeatureBuilder()
        }
    }
}
