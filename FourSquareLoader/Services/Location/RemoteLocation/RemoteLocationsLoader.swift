//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

typealias GetLocationCompletion = ([Location]) -> Void

class RemoteLocationsLoader: LocationLoader { 
    private let endpoint  = "/v3/places/nearby"
    private let LIMIT  = "5"

    func getLocations(location: String?, success: @escaping GetLocationCompletion, fail: @escaping ErrorHandler) {
        let query = [
            URLQueryItem(name: "ll", value: location),
            URLQueryItem(name: "limit", value: LIMIT),
        ]
        HttpRequester().get(endPoint: endpoint, queryItems: query, remoteObject: GetLocationResponse.self) { response in
            let remoteItems = response.results
            success(remoteItems.map{ $0.toLocation } )
        } fail: { fail($0) }
    }
}
