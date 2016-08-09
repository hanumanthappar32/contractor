//
//  ViewController.swift
//  ContractDetails
//
//  Created by Ramesh H on 09/08/16.
//  Copyright © 2016 kpwd. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var myTableview: UITableView!
    var departements:[String] = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Departements"
        
        myTableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departements.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = departements[indexPath.row]
        return cell
    }
    

    @IBAction func addDepartement(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Add Departement", message: "Add New Departement", preferredStyle: .Alert)
        let save = UIAlertAction (title: "Save", style: .Default) {
            (action:UIAlertAction) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.departements.append(textField.text!)
            self.myTableview.reloadData()
        }
        
        let cancel = UIAlertAction (title: "Cancel", style: .Default) {
            (action:UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler { (textfield:UITextField) -> Void in
        }
        alert.addAction(save)
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)

    }

}

