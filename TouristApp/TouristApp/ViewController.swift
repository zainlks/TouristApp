//
//  ViewController.swift
//  TouristApp
//
//  Created by Zain Lakhani on 2020-03-23.
//  Copyright © 2020 Zain Lakhani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        locationTextField.endEditing(true)
        locationTextField.placeholder = "Enter your location here"
    }

}

