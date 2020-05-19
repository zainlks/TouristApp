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
    @IBOutlet weak var city2: UIButton!
    @IBOutlet weak var city3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guiInit()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func guiInit() {
        city1.layer.borderWidth = 1;
        city1.layer.borderColor = UIColor.gray.cgColor
        city2.layer.borderWidth = 1;
        city2.layer.borderColor = UIColor.gray.cgColor
        city3.layer.borderWidth = 1;
        city3.layer.borderColor = UIColor.gray.cgColor
    }
    
    @IBAction func citySelected(_ sender: UIButton) {
        mapClass.performRequest(sender.currentTitle!)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
