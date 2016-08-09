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
    var departements:[NSManagedObject] = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Departements"
        
        myTableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Departement")
        
        var err : NSError?
        
        do {
            departements = try context.executeFetchRequest(request) as! [NSManagedObject]
            
            //self.departements.append(departement)
            
            
        }catch let err1 as NSError {
            err = err1
            
        }
        if(err != nil){
            print("problem with loading data")
        }
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
        let Departement = departements[indexPath.row]
        cell.textLabel?.text = Departement.valueForKey("nameOfDepartement")as? String
        
        return cell
    }
    
    func saveDepartement(name:String){
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        let departement = NSEntityDescription.insertNewObjectForEntityForName("Departement", inManagedObjectContext: context)
        departement.setValue(name, forKey: "nameOfDepartement")
        
        var err : NSError?
        
        do {
            try context.save()
            
            self.departements.append(departement)
            
            
        }catch let err1 as NSError {
            err = err1
            
        }
        if(err != nil){
            print("problem with saving data")
        }
        
        
        
    }

    @IBAction func addDepartement(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Add Departement", message: "Add New Departement", preferredStyle: .Alert)
        let save = UIAlertAction (title: "Save", style: .Default) {
            (action:UIAlertAction) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.saveDepartement(textField.text!)
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

