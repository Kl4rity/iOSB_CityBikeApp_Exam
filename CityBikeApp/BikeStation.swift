//
//  Artwork.swift
//
//  Created by Clemens Stift on 28.05.18.
//

import Foundation
import MapKit
import Contacts

class BikeStation: NSObject, MKAnnotation {
    let title: String?
    let freeBikes: Int
    var locationDescription: String
    let coordinate: CLLocationCoordinate2D
    let freeBoxesForReturn: Int
    
    init(title: String, freeBikes: Int, freeBoxesForReturn: Int, locationDescription: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.freeBikes = freeBikes
        self.locationDescription = locationDescription
        self.coordinate = coordinate
        self.freeBoxesForReturn = freeBoxesForReturn
        
        super.init()
    }
    
    init?(bikeStationDictionary: [String: Any]) {
        self.title = bikeStationDictionary["name"] as? String ?? "No Title"
        self.freeBikes = bikeStationDictionary["free_bikes"] as! Int
        self.locationDescription = bikeStationDictionary["description"] as! String
        self.freeBoxesForReturn = bikeStationDictionary["free_boxes"] as! Int
        let latitude = bikeStationDictionary["latitude"] as! Double
        let longitude = bikeStationDictionary["longitude"] as! Double
        
        if self.locationDescription.isEmpty {
            self.locationDescription = "No location description available."
        }
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var subtitle: String? {
        return  self.locationDescription + "\n\n" + String(self.freeBoxesForReturn) + " empty slots for returning bikes."
    }
    
    var markerTintColor: UIColor  {
        if freeBikes == 0 {
            return .red
        } else if freeBikes <= 3 {
            return .yellow
        } else {
            return .green
        }
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: title!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
