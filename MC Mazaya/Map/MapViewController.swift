//
//  MapViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 14/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FirebaseDatabase

let primaryColor = UIColor(rgb: 0x2B8D7B)

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    private let locationManager = CLLocationManager()
    var trademarks = [Trademark]()
    var places = [GPlace]()
    var markers = [GMSMarker]()
    var selectedTrademark : Trademark?
}

// MARK: - CLLocationManagerDelegate
//1
extension MapViewController: CLLocationManagerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        locationManager.delegate = self
        mapView.delegate = self
        // 2
        if CLLocationManager.locationServicesEnabled() {
            // 3
            locationManager.requestLocation()
            // 4
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            locationManager.startUpdatingLocation()
            getTrademarks()
        } else {
            // 5
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    //MARK: - View life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        focusMapToShowAllMarkers()
    }
    
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.requestLocation()
        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        // 7
        mapView.camera = GMSCameraPosition(
            target: location.coordinate,
            zoom: 15,
            bearing: 0,
            viewingAngle: 0)
    }
    
    // 8
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //MARK: - Mapview Delegate
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        marker.icon = UIImage(named: "marker")
    }
        
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
         if let place = marker.userData as? GPlace {
             marker.tracksInfoWindowChanges = true
             let infoWindow = UIView.viewFromNibName("MarkerInfoView") as! MarkerInfoView
             infoWindow.tag = 5555
//             let height: CGFloat = 200
//             let paddingWith = height + 16 + 32
            infoWindow.frame = CGRect(x: 0, y: 60, width: (UIScreen.main.bounds.width - 20 ) , height: 90)
            infoWindow.logoImage.layer.cornerRadius = (60 / 2)
            infoWindow.logoImage.sd_setImage(with: URL(string: place.imgUrl!))
//             infoWindow.imgView.image = UIImage(named: place.imgUrl!)
             infoWindow.nameLabel.text = place.name
            infoWindow.descriptionLabel.text = place.address
            infoWindow.layer.cornerRadius = 20
             return infoWindow
         }
         return nil
     }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let place = marker.userData as? GPlace
        self.performSegue(withIdentifier: "toTrademark", sender: place?.trademark)
    }
    
    //MARK: - Retrieve Functions
    func getTrademarks(){
        let ref = Database.database().reference().child("Trademarks")
        //        mapView.clear()
        ref.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let trade = Trademark(snap: snap)
                self.trademarks.append(trade)
            }
            self.getTrademarksPlaces()
            self.locationManager.stopUpdatingLocation()
            self.addMarkers()
        })
    }
    
    func getTrademarksPlaces(){
        for trade in trademarks {
            let branches = trade.branches!
            for branch in branches {
                if branch.latitude != "" && branch.longitude != "" {
                    let latitude = Double(branch.latitude!)
                    let longitude = Double(branch.longitude!)
                    let trademarkName = trade.trademarkName
                    let trademarkDes = trade.description
                    let tradeImage = trade.imgURL
                    let place = GPlace(name: trademarkName, address: trademarkDes, imgUrl: tradeImage, coordinates: (lat: latitude, lng: longitude) as? (lat: Double, lng: Double), trademark: trade)
                    self.places.append(place)
                }
            }
        }
    }
    
    //MARK: - Markers setup
    func addMarkers() {
        markers.removeAll()
        for (index, place) in places.enumerated() {
            let marker = GMSMarker()
            marker.icon = UIImage(named: "marker")
            marker.position = CLLocationCoordinate2D(latitude: place.coordinates!.lat, longitude: place.coordinates!.lng)
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 10)
            marker.map = self.mapView
            marker.zIndex = Int32(index)
            marker.userData = place
            markers.append(marker)
        }
    }
    
    func focusMapToShowAllMarkers() {
        if let firstLocation = markers.first?.position {
            var bounds =  GMSCoordinateBounds(coordinate: firstLocation, coordinate: firstLocation)

            for marker in markers {
                bounds = bounds.includingCoordinate(marker.position)
            }
            let update = GMSCameraUpdate.fit(bounds, withPadding: 20)
            self.mapView.animate(with: update)
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? detailsViewController ,segue.identifier == "toTrademark" {
            let sender = sender as! Trademark
            vc.tradeInfo = sender
        }
    }
    
}




