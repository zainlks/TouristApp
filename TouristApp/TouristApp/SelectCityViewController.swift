//
//  SelectCityViewController.swift
//  TouristApp
//
//  Created by Zain Lakhani on 2020-05-17.
//  Copyright © 2020 Zain Lakhani. All rights reserved.
//

import UIKit


class SelectCityViewController: UIViewController {

    @IBOutlet weak var city1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        city1.layer.borderWidth = 2;
        city1.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
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
