//
//  ViewController.swift
//  USParksExplorer
//
//  Created by Devin Ercolano on 12/31/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    private var parks: [Park] = [Park]()
    var coordinates: [CLLocation] = []
    
    let mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        // Do any additional setup after loading the view.
        
        setMapConstraints()
        addPins()
        fetchParks()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setMapConstraints() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func fetchParks() {
        APICaller.shared.getParks { [weak self] result in
            switch result {
            case .success(let parks):
                self?.parks = parks
                DispatchQueue.main.async {
                    self?.addPins()
                }
            case .failure(let error):
                print("Error in fetch parks: \(error.localizedDescription)")
            }
        }
    }
    
    func addPins() {
        let latPattern = /^lat:(.+?),/
        let longPattern = /^.+:(.+)/
        
        if !parks.isEmpty {
            for park in parks {
                let dbLatitude = Double((park.latLong).firstMatch(of: latPattern)?.1 ?? "")
                let dbLongitude = Double((park.latLong).firstMatch(of: longPattern)?.1 ?? "")

                let parkPin = MKPointAnnotation()
                parkPin.title = park.fullName
                parkPin.coordinate = CLLocationCoordinate2D(
                    latitude: dbLatitude ?? 1,
                    longitude: dbLongitude ?? 1
                )
                mapView.addAnnotation(parkPin)
            }
        }
    }
}

