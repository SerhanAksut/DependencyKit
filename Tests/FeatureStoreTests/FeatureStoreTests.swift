
import XCTest

@testable import FeatureStore

private protocol MockFeatureProtocol {}
private struct MockFeature: MockFeatureProtocol {}

final class FeatureStoreTests: XCTestCase {
    
    var featureStore: FeatureStore!
    
    override func setUp() {
        super.setUp()
        
        featureStore = FeatureStore.shared
    }
    
    override func tearDown() {
        featureStore = nil
    }
    
    func test__resolve_when_registration_successful() {
        featureStore.register(MockFeatureProtocol.self) {
            MockFeature()
        }
        let result = featureStore.resolve(MockFeatureProtocol.self)
        XCTAssertNotNil(result)
    }
    
    func test__resolve_when_registration_failed() {
        featureStore.register(MockFeatureProtocol.self) {
            nil
        }
        let result = featureStore.resolve(MockFeatureProtocol.self)
        XCTAssertNil(result)
    }
    
    func test__unregister_when_registration_successful() {
        featureStore.register(MockFeatureProtocol.self) {
            MockFeature()
        }
        let registrationResult = featureStore.resolve(MockFeatureProtocol.self)
        XCTAssertNotNil(registrationResult)
        
        featureStore.unregister(MockFeatureProtocol.self)
        let unregistrationResult = featureStore.resolve(MockFeatureProtocol.self)
        XCTAssertNil(unregistrationResult)
    }
    
    func test__unregister_when_registration_failed() {
        featureStore.register(MockFeatureProtocol.self) {
            nil
        }
        let registrationResult = featureStore.resolve(MockFeatureProtocol.self)
        XCTAssertNil(registrationResult)
        
        featureStore.unregister(MockFeatureProtocol.self)
        let unregistrationResult = featureStore.resolve(MockFeatureProtocol.self)
        XCTAssertNil(unregistrationResult)
    }
}
