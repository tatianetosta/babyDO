//
//  LoginViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-02-07.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var users: [NSManagedObject] = []
    
    @IBAction func btnForgotPassword(_ sender: Any) {
        
        let alert = UIAlertController(title: "Password Reset",
                                      message: "Enter your email",
                                      preferredStyle: .alert)
                
        let sendAction = UIAlertAction(title: "Send",
                                       style: .default)
        {
            [unowned self] action in
                                        
            guard let textField = alert.textFields?.first,
            let _ = textField.text else {
                return
            }

        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(sendAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newUserVC = storyboard.instantiateViewController(withIdentifier: "NewUserVC") as! NewUserViewController
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        appDelegate.window?.rootViewController = newUserVC
        
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        
        var messageText = ""
        var isSuccess   = false
        
        if(txtEmail.text == "") {
            messageText = "Please enter your email"
        }
        else if (txtPassword.text == "") {
            messageText = "Please enter your password"
        }
        else {
            
            isSuccess = checkUserExists(email: txtEmail.text!, password: txtPassword.text!)
            
            messageText = "Unable to login, either email or password is incorrect. Have you signed up for a babyDO account?"
        }

        
        if(isSuccess) {
            
            let defaults = Foundation.UserDefaults.standard
            defaults.set(txtEmail.text, forKey: "email")

        
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let tabBarController: UITabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController

            tabBarController.selectedIndex = 0
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
        
            appDelegate.window?.rootViewController = tabBarController
        }
        else {
            let alert = UIAlertController(title: "Login error",
                                          message: messageText,
                                          preferredStyle: .alert)
            
            alert.addAction(okAction)
            
            present(alert, animated: true)

        }
        
    }
    
    func checkUserExists(email: String, password: String) -> Bool {
        
        var found = false;
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        //3
        do {
            users = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if(users.count == 1) {
            found = true
            
            let user = users[0]
            let userid = user.value(forKeyPath: "userid") as? Int32
            
            let defaults = Foundation.UserDefaults.standard
            defaults.set(userid, forKey: "userid")
        }
        
        return found
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.resignFirstResponder()
    }


}

