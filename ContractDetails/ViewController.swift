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
    var departements:[Departement] = []
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //let context = delegate.managedObjectContext
    
    

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
            departements = try context.executeFetchRequest(request) as! [Departement]
            
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
    
        cell.textLabel?.text = departements[indexPath.row].nameOfDepartement
        
        return cell
    }
    
    // delete row
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            let item = departements[indexPath.row]
            departements.removeAtIndex(indexPath.row)
            let context = delegate.managedObjectContext
            context.deleteObject(item)
            try! context.save()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Automatic)
        }
    }
    
    
    
    func saveDepartement(name:String){
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        let departement = NSEntityDescription.insertNewObjectForEntityForName("Departement", inManagedObjectContext: context)as! Departement
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
    func nilInputAlert() {
        let title = "Alert"
        let message = "You have not typed anything"
        let okTest = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: okTest, style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(okButton)
        presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func addDepartement(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Add Departement", message: "Add New Departement", preferredStyle: .Alert)
        let save = UIAlertAction (title: "Save", style: .Default) {
            (action:UIAlertAction) -> Void in
            let textField = alert.textFields![0] as UITextField
            if (textField.text != ""){
            self.saveDepartement(textField.text!)
            }else {
                self.nilInputAlert()
            }
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

