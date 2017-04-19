//
//  MainMenuViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-14.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit
import CoreData

class MainMenuViewController: UIViewController {

    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var lblDayOfWeek: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let dayofweek = calendar.component(.weekday, from: date)
        
        let weekdays = [
            "Sun",
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat"
        ]
        
        lblDayOfWeek.text = weekdays[dayofweek - 1]

            
        btnDay.setTitle(String(day) ,for: .normal)
        
        if(hour < 12) {
            message.text = "Good morning!";
        }
        else if(hour < 18) {
            message.text = "Good afternoon!";
        }
        else {
            message.text = "Good evening!";
        }
        
      /*  let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MainMenuViewController.handleSwipes(_:)))
        
        upSwipe.direction = .up
        
        view.addGestureRecognizer(upSwipe)*/
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        let defaults = Foundation.UserDefaults.standard
        defaults.set("", forKey: "userid")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        appDelegate.window?.rootViewController = loginVC
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
