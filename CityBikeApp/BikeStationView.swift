//
//  ArtworkViews.swift
//
//  Created by Clemens Stift on 30.05.18.
//

import Foundation
import MapKit

class BikeStationMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let bikestation = newValue as? BikeStation else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControlState())
            rightCalloutAccessoryView = mapsButton
            markerTintColor = bikestation.markerTintColor
            glyphText = String(bikestation.freeBikes)
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = bikestation.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
}
