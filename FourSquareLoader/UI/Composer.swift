//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

class Composer{
    
    static func mainViewController(aboutVC: AboutUsViewController, locationVC: LocationsViewController) -> MainViewCotnroller {
        let vc = MainViewCotnroller(aboutVC: aboutVC, locationVC: locationVC)
        return vc
    }
    
    static func aboutUsViewController(loader: AboutUsLoader) -> AboutUsViewController {
        let vc = AboutUsViewController(loader: loader)
        return vc
    }

    static func locationsViewController(contoller: LocationsListController) -> LocationsViewController {
        let vc = LocationsViewController(contoller: contoller )
        return vc
    }


}
