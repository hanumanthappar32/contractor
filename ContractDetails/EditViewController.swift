//
//  EditViewController.swift
//  ContractDetails
//
//  Created by Ramesh H on 09/08/16.
//  Copyright © 2016 kpwd. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cancelbutton: UIButton!
    @IBOutlet weak var textinputbox: UITextField!
    @IBOutlet weak var okbutton: UIButton!
    @IBOutlet weak var editbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
    }

    @IBAction func okPressed(sender: AnyObject) {
    }
   
    @IBAction func editPressed(sender: AnyObject) {
    }
}
