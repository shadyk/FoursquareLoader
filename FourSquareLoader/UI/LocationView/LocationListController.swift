//
//  Created by Shady
//  All rights reserved.
//  

import UIKit
import CoreLocation

protocol LocationsListController {
    var lcoationLoader: LocationLoader { get set }

    func loadLocations(success: @escaping ([TableCellController]) -> Void,  fail: @escaping ErrorHandler)

    func didSelect(nav: UINavigationController, location: Location)
}


class LocationListController: LocationsListController{
    var lcoationLoader: LocationLoader
    
    init(locationLoader: LocationLoader) {
        self.lcoationLoader = locationLoader
    }
    
    func didSelect(nav: UINavigationController, location: Location) {
        //did select 
    }
    
    func loadLocations(success: @escaping ([TableCellController]) -> Void,  fail: @escaping ErrorHandler) {
        
        if let clocation = LocationManager.shared.currentLocation{
            self.loadFromLoader(location:clocation.toString) {
                let cellControllers = $0.map {
                    TableCellController(viewModel: $0)
                }
                success(cellControllers)
            } fail: { fail($0) }
        }
    }
    
    private func loadFromLoader(location:String?, success: @escaping GetLocationCompletion,  fail: @escaping ErrorHandler) {
        lcoationLoader.getLocations(
            location: location,
            success: { success($0) },
            fail: {  fail($0)})
    }
    
}
