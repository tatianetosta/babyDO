//
//  TrackFeedingViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-27.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit

class TrackFeedingViewController: UIViewController {

    
    @IBOutlet weak var dateTrack: UITextField!
    @IBOutlet weak var volume: UISlider!
    @IBOutlet weak var duration: UISlider!
    @IBOutlet weak var method: UISegmentedControl!
    @IBOutlet weak var labelVolume: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateTrack.text = formatter.string(from: Date())
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        
        let alert = UIAlertController(title: "Success",
                                      message: "Data saved successfully!",
                                      preferredStyle: .alert)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    
    @IBAction func sliderVolumeValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        labelVolume.text = "\(currentValue)"
    }
    
    
    @IBAction func sliderDurationValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        labelDuration.text = "\(currentValue)"
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        self.resignFirstResponder()
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
