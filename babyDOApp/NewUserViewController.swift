//
//  NewUserViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-18.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit
import CoreData

class NewUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var birthDate: UIDatePicker!
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func btnPicture(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        
        var messageText = ""
        var titleText   = "Registration Error"
        var isSuccess   = false
        
        if(fullName.text == "") {
            messageText = "Please enter your full name"
        }
        else if(email.text == "") {
            messageText = "Please enter your email"
        }
        else if(password.text == "") {
            messageText = "Please enter your password"
        }
        else if(imgUser.image == nil) {
            messageText = "Please select your picture"
        }
        else {
            titleText = "Success"
            messageText = "Welcome to babyDO!"
            
            isSuccess = true
            self.save()
        }
        
        let alert = UIAlertController(title: titleText,
                                      message: messageText,
                                      preferredStyle: .alert)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
        
        
        if(isSuccess) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let tabBarController: UITabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            
            tabBarController.selectedIndex = 0
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            appDelegate.window?.rootViewController = tabBarController
        }
        
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        appDelegate.window?.rootViewController = loginVC

    }
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        
        self.resignFirstResponder()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imgUser.layer.borderWidth = 0
        imgUser.layer.masksToBounds = false
        imgUser.layer.cornerRadius = imgUser.frame.height/2
        imgUser.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save() {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "User",
                                       in: managedContext)!
        
        let user = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        let imgData = UIImageJPEGRepresentation(imgUser.image!, 1)
        
        
        let randomNum : UInt32 = arc4random_uniform(10000)
        
        let defaults = Foundation.UserDefaults.standard
        defaults.set(randomNum, forKey: "userid")
        
        user.setValue(randomNum, forKeyPath: "userid")
        user.setValue(fullName.text, forKeyPath: "fullname")
        user.setValue(email.text, forKeyPath: "email")
        user.setValue(password.text, forKeyPath: "password")
        user.setValue(birthDate.date, forKeyPath: "birthdate")
        user.setValue(imgData, forKeyPath: "picture")
        
        // 4
        do {
            try managedContext.save()
   
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
