//
//  BabyProfileViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-02-28.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit

class BabyProfileViewController: UITableViewController {

    var babyName: String = ""
    
    @IBOutlet weak var labelName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelName.text = "\(babyName) Today"
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
