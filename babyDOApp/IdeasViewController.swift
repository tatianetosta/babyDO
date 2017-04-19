//
//  IdeasViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-27.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit

class IdeasViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerViewShopping: UIView!
    @IBOutlet weak var containerViewNews: UIView!
    @IBOutlet weak var containerViewToys: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex
        {
            case 0:
                UIView.animate(withDuration: 0.5, animations: {
                    self.containerViewShopping.alpha = 1
                    self.containerViewNews.alpha = 0
                    self.containerViewToys.alpha = 0
                })
            case 1:
                UIView.animate(withDuration: 0.5, animations: {
                    self.containerViewShopping.alpha = 0
                    self.containerViewNews.alpha = 0
                    self.containerViewToys.alpha = 1
                })
            case 2:
                UIView.animate(withDuration: 0.5, animations: {
                    self.containerViewShopping.alpha = 0
                    self.containerViewNews.alpha = 1
                    self.containerViewToys.alpha = 0
            })
            default:
                break;
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
