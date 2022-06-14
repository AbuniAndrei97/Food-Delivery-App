//
//  ViewControllerLocatie.swift
//  proiectios
//
//  Created by user216341 on 6/14/22.
//

import UIKit
import MapKit
import CoreLocation

class ViewControllerLocatie: UIViewController, MKMapViewDelegate {
    let map = MKMapView()
    let coordinate = CLLocationCoordinate2D(latitude: 40.728, longitude: -74)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        map.frame = view.bounds
        
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
        map.delegate = self
        
        addCustomPin()
    }
    
    private func addCustomPin() {
        let pin = MKPointAnnotation()
        pin.title = "Title"
        pin.subtitle = "Subtitle"
        map.addAnnotation(pin)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotationView) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        var annotationView: MKAnnotationView?
        
        return annotationView
    }
}
