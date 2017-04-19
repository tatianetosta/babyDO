//
//  NewBabyViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-02-28.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit
import CoreData

class NewBabyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgBaby: UIImageView!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var birthdate: UIDatePicker!
    @IBOutlet weak var genre: UISegmentedControl!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imgBaby.layer.borderWidth = 0
        imgBaby.layer.masksToBounds = false
        imgBaby.layer.cornerRadius = imgBaby.frame.height/2
        imgBaby.clipsToBounds = true

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnPicture(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        
        var messageText = ""
        var titleText   = "Error"
        
        if(fullname.text == "") {
            messageText = "Please enter his/her full name"
        }
        else if(imgBaby.image == nil) {
            messageText = "Please select his/her picture"
        }
        else {
            titleText = "Success"
            messageText = "New baby registered successfully!"
            
            self.save()
        }

        let alert = UIAlertController(title: titleText,
                                      message: messageText,
                                      preferredStyle: .alert)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
        
        
    }
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imgBaby.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    func save() {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Baby",
                                       in: managedContext)!
        
        let baby = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        let imgData = UIImageJPEGRepresentation(imgBaby.image!, 1)
        
        
        var userid = 0
        let defaults = Foundation.UserDefaults.standard
        if let id = defaults.object(forKey: "userid") as? Int32 {
            userid = Int(id)
        }

        let randomNum : UInt32 = arc4random_uniform(10000)

        
        baby.setValue(userid, forKeyPath: "userid")
        baby.setValue(randomNum, forKeyPath: "babyid")
        baby.setValue(fullname.text, forKeyPath: "fullname")
        baby.setValue(genre.titleForSegment(at: genre.selectedSegmentIndex), forKeyPath: "genre")
        baby.setValue(birthdate.date, forKeyPath: "birthdate")
        baby.setValue(imgData, forKeyPath: "picture")
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
