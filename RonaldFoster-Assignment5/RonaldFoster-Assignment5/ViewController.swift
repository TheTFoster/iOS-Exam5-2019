//
//  ViewController.swift
//  RonaldFoster-Assignment5
//
//  Created by TJ Foster on 6/27/19.
//  Copyright © 2019 TJ Foster. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController
{
    @IBOutlet weak var txtContactName: UITextField!
    @IBOutlet weak var txtContactEmail: UITextField!
    @IBOutlet weak var txtContactPhone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.RetrieveDataFromCore()
    }

    @IBAction func saveToCore(_ sender: Any)
    {
        let anActionSheet = UIAlertController(title: "Save contact?", message: "Are you sure you want to save contact?", preferredStyle: .alert)
        let yesActionButton = UIAlertAction(title: "Yes, save", style: .default) { (saveDataToCore) in self.saveDataToCore()
            print("Saved successfully")
        }
        let noActionButton = UIAlertAction(title: "No, cancel", style: .destructive, handler: nil)
        anActionSheet.addAction(yesActionButton)
        anActionSheet.addAction(noActionButton)
       present(anActionSheet, animated: true, completion: nil)
    }
    @IBAction func retrieveFromCore(_ sender: UIButton)
    {
        self.RetrieveDataFromCore()
    }
    @IBAction func clearTextBoxes(_ sender: UIButton)
    {
        txtContactName.text = ""
        txtContactEmail.text = ""
        txtContactPhone.text = ""
    }
    
    func saveDataToCore()
    {
        //build a reference tp AppDelegate file
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = appDelegate.persistentContainer.viewContext
        let myConatctDescription = NSEntityDescription.entity(forEntityName:"Contact", in:myContext)
        let aContact = NSManagedObject(entity:myConatctDescription!, insertInto: myContext)
        aContact.setValue(txtContactName.text, forKey:"name")
        aContact.setValue(txtContactEmail.text, forKey:"emailAddress")
        aContact.setValue(txtContactPhone.text, forKey:"phoneNumber")
        do {
            try myContext.save()
            print("Saved Successfully")
        } catch
        {
            print("Save Failed")
        }
}
    func RetrieveDataFromCore()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do {
            let contacts = try myContext.fetch(fetchRequest)
            if contacts.count > 0
            {
                let aContact = contacts[contacts.count - 1]
                txtContactName.text = ((aContact as AnyObject).value(forKey: "name") as! String)
                txtContactEmail.text = ((aContact as AnyObject).value(forKey: "emailAddress") as! String)
                txtContactPhone.text = ((aContact as AnyObject).value(forKey: "phoneNumber") as! String)
            }
        }
        catch
        {
            print("fetch failed")
        }
    }
    @IBAction func tapGesture(_ sender: Any)
    {
        dismissKeyboard()
    }
    func dismissKeyboard()
    {
        txtContactName.resignFirstResponder()
        txtContactEmail.resignFirstResponder()
        txtContactPhone.resignFirstResponder()
    }
}
