//
//  NearbyHikeInformationViewController.swift
//  HikeAppCP
//
//  Created by Joshua Storey on 3/21/20.
//  Copyright © 2020 Joshua Storey. All rights reserved.
//

import UIKit
import MapKit

class NearbyHikeInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    var lat : Double?
    var long : Double?
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
           if let count = trailsItems?.count
           {
               return count
           }else
           {
               return 0
           }
    }
    @IBOutlet weak var hikesTable: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = hikesTable.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        cell.layer.borderWidth = 1.0
        let news = trailsItems?[indexPath.row]
        cell.textLabel?.text = news?.name!
        
        if let author = news?.location
        {
           cell.detailTextLabel?.text = news?.location!
        }else
        {
            cell.detailTextLabel?.text = "no location"
        }
        
        
        
        return cell
    }
    
   
   
    struct hikes: Decodable {
        let trails: [Trail]
       }
       
       struct Trail: Decodable {
           let name: String?
           let location : String?
           let stars : Double?
           
       }
    var trailsItems:[Trail]?
    
   
    
 
    
      func getNews() {
          
        
          let urlAsString = "https://www.hikingproject.com/data/get-trails?lat=" + String(lat!) + "&lon=" + String(long!) + "&maxDistance=10&key=200733322-4cb17a9e16e730ff90b443bcde8af277"
          
          let url = URL(string: urlAsString)!
          
          let urlSession = URLSession.shared
          
          
          let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
              if (error != nil) {
                  print(error!.localizedDescription)
              }
              var err: NSError?
              
              let decoder = JSONDecoder()
              let jsonResult = try! decoder.decode(hikes.self, from: data!)
          
              if (err != nil) {
                  print("JSON Error \(err!.localizedDescription)")
              }
              print(jsonResult)
           
              
              self.trailsItems = jsonResult.trails
              
         
              DispatchQueue.main.async(execute: {
                  self.hikesTable.reloadData()
              })

              
              
    
              
          })
          
          jsonQuery.resume()
          
      }
    
    // delete table entry
    // this method makes each row editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // return the table view style as deletable
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
       {
        
        if editingStyle == .delete
        {
            
         
            self.trailsItems?.remove(at: indexPath.row)
            print("item deleted")
            self.hikesTable.reloadData()
        }
        
    }
    
      

    @IBAction func getLocations(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async(execute: {
                   self.getNews()
               })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue : CLLocationCoordinate2D = manager.location!.coordinate
        lat = locValue.latitude
        long = locValue.longitude
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!,latitudinalMeters: 600,longitudinalMeters: 600)
        self.map.setRegion(viewRegion,animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
