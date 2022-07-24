//
//  LocationManager.swift
//  Rabet
//
//  Created by Muhannad Alnemer on 03/11/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
	private override init() {}
    
	static var shared = LocationManager()
	private(set) lazy var locationManager: CLLocationManager = {
		let lm = CLLocationManager()
		lm.delegate = self
		lm.startUpdatingLocation()
		return lm
	}()
    
    var currentLocationChanged: () -> Void  = { }
    var currentLocation: CLLocation?
    
    func requestAlwaysAuthorization(currentLocationChanged: @escaping () -> Void) {
        self.currentLocationChanged = currentLocationChanged
        locationManager.requestAlwaysAuthorization()
	}

	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		switch manager.authorizationStatus {
		case .notDetermined:
            manager.requestLocation()
		case .restricted, .denied, .authorizedAlways, .authorizedWhenInUse:
			break
		@unknown default:
			fatalError()
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		currentLocation = location
        currentLocationChanged()
        locationManager.stopUpdatingLocation()
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		if [.denied, .notDetermined].contains(manager.authorizationStatus) {
			manager.requestLocation()
		}
        else{
            debugPrint(error)
        }
	}
}

extension CLLocation {
	var toString: String? {
		let lat = "\(self.coordinate.latitude)".prefix(10)
		let long = "\(self.coordinate.longitude)".prefix(10)
		return "\(lat),\(long)"
	}
}
