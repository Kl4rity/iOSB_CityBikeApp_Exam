import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var bikestations: [BikeStation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 48.208415, longitude: 16.371282)
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        //        mapView.register(ArtworkMarkerView.self,
        //                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        mapView.register(BikeStationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        loadInitialData()
        
        debugPrint(bikestations)
        
        mapView.addAnnotations(bikestations)
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData() {
        debugPrint("I'm in the function.")
        guard let fileName = Bundle.main.path(forResource: "Citybikes", ofType: "json")
            else {return}
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))

        guard
            let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let stations = json as? [[String: Any]]
        
            else { debugPrint("Shit happened."); return}
        
        debugPrint("List of stations now:")
        debugPrint(stations)
        
        var validStations = [BikeStation]()
        for station in stations {
            var typeCastedStation = BikeStation(bikeStationDictionary: station)
            validStations.append(typeCastedStation!)
        }
        
        bikestations.append(contentsOf: validStations)
        
    }
    
}

extension ViewController: MKMapViewDelegate {
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        guard let annotation = annotation as? Artwork else { return nil }
    //        let identifier = "marker"
    //        var view: MKMarkerAnnotationView
    //        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    //            as? MKMarkerAnnotationView {
    //            dequeuedView.annotation = annotation
    //            view = dequeuedView
    //        } else {
    //            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    //            view.canShowCallout = true
    //            view.calloutOffset = CGPoint(x: -5, y: 5)
    //            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    //        }
    //        return view
    //    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! BikeStation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}

