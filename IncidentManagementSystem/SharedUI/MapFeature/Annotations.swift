//
//  Annotations.swift
//  HafalatUI
//
//  Created by MahmoudFares on 21/07/2023.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class CustomAnnotation: NSObject, MapViewAnnotation, Identifiable {
    
    let coordinate: CLLocationCoordinate2D
    
    let title: String?
    
    let id = UUID()
    
    let clusteringIdentifier: String? = "exampleCluster"
    
    let glyphImage: UIImage?
    
    let tintColor: UIColor? = .purple
    
    init(
        title: String,
        coordinate: CLLocationCoordinate2D,
        image: String = "house.fill"
    ) {
        self.title = title
        self.coordinate = coordinate
        self.glyphImage = UIImage(systemName: image)?.withTintColor(.white)
    }
    
}
extension Array where Element == CustomAnnotation {
    static var examples: [CustomAnnotation] = {
        [
            CustomAnnotation(title: "Apple Park", coordinate: .applePark),
            CustomAnnotation(title: "Infinite Loop", coordinate: .inifiniteLoop),
        ]
    }()
}

extension CLLocationCoordinate2D {
    
    static var inifiniteLoop: CLLocationCoordinate2D = {
        CLLocationCoordinate2D(latitude: 37.331836, longitude: -122.029604)
    }()
    
    static var applePark: CLLocationCoordinate2D = {
        CLLocationCoordinate2D(latitude: 37.334780, longitude: -122.009073)
    }()
    
}
