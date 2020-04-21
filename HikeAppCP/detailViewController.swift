//
//  detailViewController.swift
//  HikeAppCP
//
//  Created by Joshua Storey on 4/21/20.
//  Copyright © 2020 Joshua Storey. All rights reserved.
//

import UIKit
import CoreData
class detailViewController: UIViewController {
    var name : String?
    var distance : String?
    var time : String?
    var picture : NSData?
    var picture1 : UIImage?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        timeTF.text = time
        distanceTF.text = distance
        nameTF.text = name
        if picture != nil {
        imageView?.image =  UIImage(data: picture  as! Data)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var timeTF: UILabel!
    @IBOutlet weak var nameTF: UILabel!
    
    @IBOutlet weak var distanceTF: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
