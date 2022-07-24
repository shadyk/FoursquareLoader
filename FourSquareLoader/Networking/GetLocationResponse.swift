//
//  Created by Shady
//  All rights reserved.
//
import Foundation

struct GetLocationResponse: Codable {
    let results: [RemoteResult]
}

// MARK: - Result
struct RemoteResult: Codable {
    let fsqID: String
    let categories: [RemoteCategory]
    let chains: [RempteChain]
    let distance: Int
    let geocodes: RemoteGeocodes?
    let link: String
    let location: RemoteLocation
    let name: String
    let relatedPlaces: RemoteRelatedPlaces
    let timezone: String

    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case categories, chains, distance, geocodes, link, location, name
        case relatedPlaces = "related_places"
        case timezone
    }
}

// MARK: - Category
struct RemoteCategory: Codable {
    let id: Int
    let name: String
    let icon: Icon
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String
    let suffix: String

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

// MARK: - Chain
struct RempteChain: Codable {
    let id, name: String
}

// MARK: - Geocodes
struct RemoteGeocodes: Codable {
    let main: Main?
}

// MARK: - Main
struct Main: Codable {
    let latitude, longitude: Double?
}

// MARK: - Location
struct RemoteLocation: Codable {
    let address: String?
    let country, crossStreet, formattedAddress: String?
    let locality: String?
    let postcode: String
    let region: String?

    enum CodingKeys: String, CodingKey {
        case address, country
        case crossStreet = "cross_street"
        case formattedAddress = "formatted_address"
        case locality, postcode, region
    }
}

// MARK: - RelatedPlaces
struct RemoteRelatedPlaces: Codable {
    let parent: Parent?
    let children: [Parent]?
}

// MARK: - Parent
struct Parent: Codable {
    let name: String
    let fsqID: String?

    enum CodingKeys: String, CodingKey {
        case name
        case fsqID = "fsq_id"
    }
}
