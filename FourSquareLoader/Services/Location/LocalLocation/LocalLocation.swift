// Copyright ©  Shady Kahaleh. All rights reserved.

import Foundation

struct LocalLocation {
    var ID : String
    var name : String
}

//MARK: - mappers from Location from/to LocalLocation
extension Array where Element == Location {
    
    var toLocal: [LocalLocation] {
        return map { LocalLocation(ID: $0.ID, name: $0.name) }
    }
}

extension Array where Element == LocalLocation {
    var toModels: [Location] {
        return map {
            Location(ID: $0.ID,
                       name: $0.name)
        }
    }
}
