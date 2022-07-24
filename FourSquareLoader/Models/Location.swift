//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

struct Location{
    var ID: String = UUID().uuidString
    var name: String
    
    var toLocal: [LocalLocation] {
        return [LocalLocation(ID: self.ID, name: self.name)]
    }
}


extension RemoteResult{
    var toLocation: Location{
        return Location(name: name)
    }
}
