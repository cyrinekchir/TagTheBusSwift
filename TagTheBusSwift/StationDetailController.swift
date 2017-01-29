//
//  StationDetailController.swift
//  TagTheBusSwift
//
//  Created by cyrine on 27/01/2017.
//  Copyright © 2017 cyrine. All rights reserved.
//

import UIKit
import MapKit

class StationDetailController: UIViewController {

    
    
    
    var currentStation = Station()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var busesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       cityLabel.text = currentStation.city
       busesLabel.text = currentStation.buses
       nameLabel.text = currentStation.streetName as String?
        
        let annotation = MKPointAnnotation()
        annotation.title = currentStation.streetName as String?
        annotation.subtitle = currentStation.city
        let latitude:CLLocationDegrees = Double(currentStation.latitude!)!
        let longitude:CLLocationDegrees=Double(currentStation.longitude!)!
        
        let latDelta:CLLocationDegrees=0.005
        let longDelta:CLLocationDegrees=0.005
        let span:MKCoordinateSpan=MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let location:CLLocationCoordinate2D=CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region:MKCoordinateRegion=MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        annotation.coordinate=location
        
        
        mapView.addAnnotation(annotation)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    

    

}
