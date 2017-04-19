//
//  TrachDiapersViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-27.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit

class TrackDiapersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var dateTrack: UITextField!
    @IBOutlet weak var size: UIPickerView!
    @IBOutlet weak var brand: UIPickerView!
    @IBOutlet weak var quantity: UISlider!
    
    @IBOutlet weak var labelQty: UILabel!
    
    var pickerSize: [String] = [String]()
    var pickerBrand: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerSize = ["Newborn", "Size 1", "Size 2", "Size 3", "Size 4", "Size 5", "Size 6", "Size 7"]
        pickerBrand = ["Pampers", "Huggies", "Bumkins", "G Diapers", "Whole Foods 365 Everyday", "Seventh Generation", "Other"]

        brand.dataSource = self
        brand.delegate = self
        
        size.dataSource = self
        size.delegate = self
        
        brand.tag = 1
        size.tag = 2
        
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
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        labelQty.text = "\(currentValue)"
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return pickerBrand.count
        }
        else {
            return pickerSize.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if pickerView.tag == 1{
            return pickerBrand[row]
        }
        else {
            return pickerSize[row]
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1{
            print(pickerBrand[row])
        }
        else {
            print(pickerSize[row])
        }

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
