//
//  MapViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-02-28.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Foundation


class MapViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 200

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationAuthorizationStatus()

        dropPins()
        
        // Do any additional setup after loading the view.
    }
    
    func dropPins() {
        var storeLocation = CLLocationCoordinate2DMake(49.2588614, -123.0269993)
        // Drop a pin
        var dropPin = MKPointAnnotation()
        dropPin.coordinate = storeLocation
        dropPin.title = "Walmart"
        mapView.addAnnotation(dropPin)
        
        storeLocation = CLLocationCoordinate2DMake(49.226526, -123.003818)
        // Drop a pin
        dropPin = MKPointAnnotation()
        dropPin.coordinate = storeLocation
        dropPin.title = "Bed Bath & Beyond"
        mapView.addAnnotation(dropPin)
        
        storeLocation = CLLocationCoordinate2DMake(49.226657,-123.0678873)
        // Drop a pin
        dropPin = MKPointAnnotation()
        dropPin.coordinate = storeLocation
        dropPin.title = "Sears"
        mapView.addAnnotation(dropPin)
        
    }
    
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        mapView.isZoomEnabled = true;
        mapView.isScrollEnabled = true;
        mapView.isUserInteractionEnabled = true;
        mapView.showsUserLocation = true;

    }
    
    /* func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        
    /*    var coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        
        coordinateRegion.span.longitudeDelta  = 0.004; // set required zoom value
        coordinateRegion.span.latitudeDelta  = 0.004;
        
        mapView.setRegion(coordinateRegion, animated: true)*/

        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }*/


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
