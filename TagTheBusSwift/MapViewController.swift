//
//  MapViewController.swift
//  TagTheBusSwift
//
//  Created by cyrine on 27/01/2017.
//  Copyright © 2017 cyrine. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class MapViewController: UIViewController , MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var annotations = [MKPointAnnotation]()
    var stationsList: [Station] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        Alamofire.request("http://barcelonaapi.marcpous.com/bus/nearstation/latlon/41.3985182/2.1917991/1.json").responseJSON { response in
            if let JSON = response.result.value{
                let info = JSON as! NSDictionary
                if let data=info["data"]as? NSDictionary{
                    let stations = data["nearstations"] as! NSArray
                    for index in 1...stations.count-1 {
                        let jsonData = stations[index]as! NSDictionary
                        let station=Station()
                        station.fetchStation(dictionary: jsonData)
                        let annotation = MKPointAnnotation()
                        annotation.title = station.streetName as String?
                        annotation.subtitle = station.city
                        let latitude:CLLocationDegrees = Double(station.latitude!)!
                        let longitude:CLLocationDegrees=Double(station.longitude!)!
                        
                        let latDelta:CLLocationDegrees=0.005
                        let longDelta:CLLocationDegrees=0.005
                        let span:MKCoordinateSpan=MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
                        let location:CLLocationCoordinate2D=CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        let region:MKCoordinateRegion=MKCoordinateRegion(center: location, span: span)
                        
                        self.mapView.setRegion(region, animated: true)
                        annotation.coordinate=location
                        
                        
                        self.mapView.addAnnotation(annotation)
                    }
                   
                }
                
            }
        }

        
        
        
        
        

      
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
   
}
