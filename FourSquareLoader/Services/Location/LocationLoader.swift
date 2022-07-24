//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

protocol LocationLoader{
    func getLocations(location:String?, success: @escaping GetLocationCompletion, fail: @escaping ErrorHandler)
}

extension LocationLoader {
    func caching(to cache: LocationCache) -> LocationLoader {
        LocationLoaderCacheDecorator(decoratee: self, cache: cache)
    }

    func fallback(to fallback: LocationLoader) -> LocationLoader {
        LocationLoaderWithFallbackComposite(primary: self, fallback: fallback)
    }
}


