//
//  Copyright © . All rights reserved.
//
import Foundation

class LocationLoaderWithFallbackComposite: LocationLoader {
    private let primary: LocationLoader
    private let fallback: LocationLoader
    
    init(primary: LocationLoader, fallback: LocationLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func getLocations(location: String?, success: @escaping GetLocationCompletion, fail: @escaping ErrorHandler) {
        primary.getLocations(location: location, success: { [weak self] locations in
            guard let self = self else {return}
            if locations.count > 0 {
                success(locations)
            }
            else{
                self.fallback.getLocations(location: location, success: success, fail: fail)
            }
        }, fail: { fail($0) })
    }
}
