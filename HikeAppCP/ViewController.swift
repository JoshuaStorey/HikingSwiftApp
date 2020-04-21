//
//  ViewController.swift
//  HikeAppCP
//
//  Created by Joshua Storey on 3/21/20.
//  Copyright © 2020 Joshua Storey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let imageName = "Logo.png"
        let image = UIImage(named: imageName)
        Logo.image = image
        let imageName1 = "Frontpage.jpeg"
        let image1 = UIImage(named: imageName1)
        firstImage.image = image1
    }


    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var Logo: UIImageView!
    @IBAction func nearestButton(_ sender: Any) {
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
    }
    
    @IBAction func viewButton(_ sender: Any) {
    }
    
}

