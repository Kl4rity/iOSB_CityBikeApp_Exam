//
//  Artwork.swift
//  HonoluluArt
//
//  Created by Clemens Stift on 28.05.18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class BikeStation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(bikeStationDictionary: [String: Any]) {
        self.title = bikeStationDictionary["name"] as? String ?? "No Title"
        self.locationName = bikeStationDictionary["description"] as! String
        self.discipline = bikeStationDictionary["status"] as! String
        let latitude = bikeStationDictionary["longitude"] as! Double
        let longitude = bikeStationDictionary["latitude"] as! Double
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        debugPrint(self.coordinate)
        
    }
    
    // TODO Change this to return a different location name.
    var subtitle: String? {
        return locationName
    }
    
    // TODO Change this to reflect different levels of free bikes.
    var markerTintColor: UIColor  {
        switch discipline {
        case "Monument":
            return .red
        case "Mural":
            return .cyan
        case "Plaque":
            return .blue
        case "Sculpture":
            return .purple
        default:
            return .green
        }
    }
    
    var imageName: String? {
        if discipline == "Sculpture" { return "Statue" }
        return "Flag"
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
