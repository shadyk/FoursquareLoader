//
//  Created by Shady
//  All rights reserved.
//  

import Foundation
protocol LocationCache {
    typealias CacheResult = Result<Void,Error>
    
    func save(locations: [Location], completion: @escaping(CacheResult)->Void)
}
