//
//  LocationManager.swift
//  IncidentManagementSystem
//
//  Created by MahmoudFares on 28/09/2023.
//

import Foundation
import CoreLocation
import Combine
import MapKit
import Contacts
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?

     @Published var lastLocation: CLLocation? {
       willSet { objectWillChange.send() }
     }

    // 2
    var latitude: CLLocationDegrees {
        return lastLocation?.coordinate.latitude ?? 0
    }

    var longitude: CLLocationDegrees {
        return lastLocation?.coordinate.longitude ?? 0
    }
    // From here and down is new


    @Published var hasSetRegion = false


    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

   
    
    var statusCheck: Bool {
        guard let status = locationStatus else {
            return false
        }
        
        switch status {
        case .notDetermined: return false
        case .authorizedWhenInUse: return true
        case .authorizedAlways: return true
        case .restricted: return false
        case .denied: return false
        default: return false
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        locationManager.stopUpdatingLocation()
        if shouldUpdateLocation(to: newLocation) {
            lastLocation = newLocation
        }

    }
    private func shouldUpdateLocation(to location: CLLocation) -> Bool {
        guard let lastKnownLocation = lastLocation else { return true }
        let distanceInMeters = Measurement(value: lastKnownLocation.distance(from: location), unit: UnitLength.meters)
        let distanceInMiles = distanceInMeters.converted(to: .miles)
        if distanceInMiles.value > 2 { return true }
        return false
    }
    
    func getAddress(lat: Double, long: Double) -> String {
        let geocoder = CLGeocoder()
        var address = ""
        geocoder.reverseGeocodeLocation(CLLocation(latitude: lat, longitude: long)) { response, error in
            if error != nil {
                address = "reverse geodcode fail: \(error!.localizedDescription)"
                        } else {
                            if let places = response {
                                if let place = places.first {

                                    address = "Error"
                                    if let lines = place.locality {
                                        address = "\(lines), \(place.country ?? "")"
                                    }

                                } else {
                                    address = "GEOCODE: nil first in places"
                                }
                            } else {
                                address = "GEOCODE: nil in places"
                            }
                        }
        }
        return address
    }
    
    func getAddrFrmLtLng(latitude: Any, longitude: Any) async throws -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude as! CLLocationDegrees, longitude: longitude as! CLLocationDegrees)

        do {
            let placemarks = try await geoCoder.reverseGeocodeLocation(location)
            return displayLocationInfo(placemark: placemarks.first)
        } catch {
            throw error
        }
    }

    func displayLocationInfo(placemark: CLPlacemark?) -> String {
        guard let containsPlacemark = placemark else {
            return ""
        }

        let addressFormatter = CNPostalAddressFormatter()
        addressFormatter.style = .mailingAddress

        var adr: String = ""

            var addressComponents: [String] = []

            if let subThoroughfare = containsPlacemark.subThoroughfare {
                addressComponents.append(subThoroughfare)
            }
            if let thoroughfare = containsPlacemark.thoroughfare {
                addressComponents.append(thoroughfare)
            }
            if let subLocality = containsPlacemark.subLocality {
                addressComponents.append(subLocality)
            }
            if let locality = containsPlacemark.locality {
                addressComponents.append(locality)
            }
            if let country = containsPlacemark.country {
                addressComponents.append(country)
            }

            adr = addressComponents.joined(separator: ", ")
        return adr
    }


}



