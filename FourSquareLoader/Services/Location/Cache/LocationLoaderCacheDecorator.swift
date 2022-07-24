//
//  Copyright ©  . All rights reserved.
//

import Foundation

final class LocationLoaderCacheDecorator: LocationLoader {
	private let decoratee: LocationLoader
	private let cache: LocationCache
	
	init(decoratee: LocationLoader, cache: LocationCache) {
		self.decoratee = decoratee
		self.cache = cache
	}
    func getLocations(location: String?, success: @escaping GetLocationCompletion, fail: @escaping ErrorHandler) {
        decoratee.getLocations(location: location) { [weak self] locations in
            self?.cache.saveIgnoringResult(locations)
            success(locations)
        } fail: { fail($0) }
    }
}

private extension LocationCache {
	func saveIgnoringResult(_ location: [Location]) {
        save(locations: location) { _ in }
	}
}
