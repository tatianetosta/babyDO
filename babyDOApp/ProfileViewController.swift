//
//  ProfileViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-18.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var birthDate: UIDatePicker!
    
    let imagePicker = UIImagePickerController()
    
    var users: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imgUser.layer.borderWidth = 0
        imgUser.layer.masksToBounds = false
        imgUser.layer.cornerRadius = imgUser.frame.height/2
        imgUser.clipsToBounds = true


        var userid = 0
        
        let defaults = Foundation.UserDefaults.standard
        if let id = defaults.object(forKey: "userid") as? Int32 {
            userid = Int(id)
        }

        getUserInfo(id: Int32(userid))
        
        if(users.count > 0)
        {
            let user = users[0]
            
            email.text = user.value(forKeyPath: "email") as? String
            fullname.text = user.value(forKeyPath: "fullname") as? String
            password.text = user.value(forKeyPath: "password") as? String
            birthDate.date = (user.value(forKeyPath: "birthdate") as? Date)!
        
            let imgData = user.value(forKeyPath: "picture") as? Data
        
            imgUser.image = UIImage(data: imgData!)
        }
        
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
        var titleText   = "Update error"
        
        if(fullname.text == "") {
            messageText = "Please enter your full name"
        }
        else if(password.text == "") {
            messageText = "Please enter your password"
        }
        else {
            titleText = "Success"
            messageText = "Profile updated successfully!"
 
            self.save()
        }
        
        let alert = UIAlertController(title: titleText,
                                      message: messageText,
                                      preferredStyle: .alert)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)


    }
    
    
    func getUserInfo(id: Int32) {
 
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "userid == %@", NSNumber(value: id))
        
        do {
            users = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }

    
    func save() {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let imgData = UIImageJPEGRepresentation(imgUser.image!, 1)
        
        users[0].setValue(fullname.text, forKeyPath: "fullname")
        users[0].setValue(password.text, forKeyPath: "password")
        users[0].setValue(birthDate.date, forKeyPath: "birthdate")
        users[0].setValue(imgData, forKeyPath: "picture")
        
        appDelegate.saveContext()
    }
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.resignFirstResponder()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imgUser.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
