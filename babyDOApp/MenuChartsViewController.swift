//
//  MenuChartsViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-24.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit

class MenuChartsViewController: UITableViewController {

    var menuItems = ["Diapers", "Feeding", "Sleep"]
    var currentItem = "Diapers"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuTableViewCell
        
        self.tableView.separatorStyle = .none
        
        // Configure the cell...
        cell.titleLabel?.text = menuItems[indexPath.row]
        cell.titleLabel?.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.black : UIColor.white
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let menuTableViewController = segue.source as! MenuChartsViewController
        if let selectedIndexPath = menuTableViewController.tableView.indexPathForSelectedRow {
            currentItem = menuItems[selectedIndexPath.row]
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
