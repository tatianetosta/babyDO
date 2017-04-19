//
//  ListBabiesViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-18.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit
import CoreData

class ListBabiesViewController: UITableViewController {
        
    @IBOutlet var appTableView: UITableView!
    var babies: [NSManagedObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Baby"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
        self.appTableView.reloadData()
        print("viewWillAppear")
    }
    
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return babies.count
    }
    
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let baby = babies[indexPath.row]
            
            let cell:BabyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BabyTableViewCell
            
            cell.name?.text = baby.value(forKeyPath: "fullname") as? String

            let imgData = baby.value(forKeyPath: "picture") as? Data
            
            cell.babyImg?.image = UIImage(data: imgData!)
            
            return cell
    }
    
    func getData() {
        var userid = 0
        
        let defaults = Foundation.UserDefaults.standard
        if let id = defaults.object(forKey: "userid") as? Int32 {
            userid = Int(id)
        }
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Baby")
        
        fetchRequest.predicate = NSPredicate(format: "userid == %@", NSNumber(value: userid))
        
        
        //3
        do {
            babies = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("You selected cell #\(tableView.indexPathForSelectedRow?.row)!")
    
        if(tableView.indexPathForSelectedRow?.row != nil) {
            let baby = babies[(tableView.indexPathForSelectedRow?.row)!]
    
            let controller = segue.destination as! BabyProfileViewController
            controller.babyName = (baby.value(forKeyPath: "fullname") as? String)!
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

