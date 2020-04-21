//
//  myHikesViewController.swift
//  HikeAppCP
//
//  Created by Joshua Storey on 4/21/20.
//  Copyright © 2020 Joshua Storey. All rights reserved.
//

import UIKit
import CoreData

class myHikesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         var m:Model?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
           
        return (m?.fetchRecord().count)!
       
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // add each row from coredata fetch results
               let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
               cell.layer.borderWidth = 1.0
               cell.textLabel?.text = m?.fetchRecord()[indexPath.row].name
        cell.detailTextLabel?.text = m?.fetchRecord()[indexPath.row].distance
        if let picture = m?.fetchRecord()[indexPath.row].picture {
                cell.imageView?.image =  UIImage(data: picture  as Data)
            } else {
                cell.imageView?.image = nil
            }
               
              
               
               return cell
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model(context: managedObjectContext)
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var myHikeTbl: UITableView!
    
    
     @IBAction func addHike(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Hike", message: "", preferredStyle:   .alert)
             alertController.addTextField(configurationHandler: {textField in textField.placeholder = "Enter Name of Hike"})
             alertController.addTextField(configurationHandler: {textField in textField.placeholder = "Enter Distance"})
             alertController.addTextField(configurationHandler: {textField in textField.placeholder = "Enter Time"})
             
             let libraryAction = UIAlertAction(title:"Picture", style : .default) { (action) in
                 // m?.
                 self.m?.SaveContext(name: (alertController.textFields?.first!.text)!, distance: alertController.textFields![1].text!, time: alertController.textFields![2].text!)
                self.myHikeTbl.reloadData()
                 
                 let picker = UIImagePickerController()
                 picker.delegate = self
                 picker.sourceType = .photoLibrary
                 self.present(picker, animated: true, completion: nil)
                 
                 
             }
             let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                  self.m?.SaveContext(name: (alertController.textFields?.first!.text)!, distance: alertController.textFields![1].text!, time: alertController.textFields![2].text!)
                self.myHikeTbl.reloadData()
                 if UIImagePickerController.isSourceTypeAvailable(.camera) {
                     let picker = UIImagePickerController()
                     picker.allowsEditing = false
                     picker.sourceType = UIImagePickerController.SourceType.camera
                     picker.cameraCaptureMode = .photo
                     picker.modalPresentationStyle = .fullScreen
                     self.present(picker,animated:  true, completion: nil)
                     
                 }else {
                     print("NO CAMERA")
                    //self.myHikeTbl.reloadData()
                 }
             }
             let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                 
             }
             alertController.addAction(cancelAction)
            alertController.addAction(libraryAction)
             alertController.addAction(cameraAction)
             
             self.present(alertController, animated: true, completion: nil)
             myHikeTbl.reloadData()
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
               
               // delete the selected object from the managed
               // object context
               m?.managedObjectContext!.delete((m?.fetchRecord()[indexPath.row])!)
               
               //updateLastRow()
               myHikeTbl.reloadData()
           }
           
       }
    func updateLastRow() {
             let indexPath = IndexPath(row: (m?.fetchRecord().count)! - 1, section: 0)
        myHikeTbl.reloadRows(at: [indexPath], with: .automatic)
         }
         
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
           
           picker .dismiss(animated: true, completion: nil)

           // fetch resultset has the recently added row without the image
           // this code ad the image to the row
           if let hike = m?.fetchRecord().last , let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               hike.picture = image.pngData()! as NSData
               //update the row with image
               updateLastRow()
               do {
                   try m?.managedObjectContext!.save()
               } catch {
                   print("Error while saving the new image")
               }
               
           }
           
       }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.myHikeTbl.indexPath(for: sender as! UITableViewCell)!
        
       
        
               // access the section for the selected row
             //  let cityKey = myCityList.citySectionTitles[selectedIndex.section]
            
               // get the fruit object for the selected row in the section
              // let city = myCityList.getCityObjectforRow(key:cityKey, //index:selectedIndex.row)
        var name1 = m?.fetchRecord()[selectedIndex.row].name
         var distance1 = m?.fetchRecord()[selectedIndex.row].distance
         var time1 = m?.fetchRecord()[selectedIndex.row].time
        let picture1 = m?.fetchRecord()[selectedIndex.row].picture
        if(segue.identifier == "detailViewHike"){
            if let viewController: detailViewController = segue.destination as? detailViewController {
                viewController.name = name1
                viewController.distance = distance1
                viewController.time = time1
                viewController.picture = picture1
                
                
            }
        }
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
