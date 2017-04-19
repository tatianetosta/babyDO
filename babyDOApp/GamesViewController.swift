//
//  GamesViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-27.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var imgToy: UIImageView!
    @IBOutlet var btniTunes: UIImageView!
    @IBOutlet var labelName: UILabel!
    
    var appStoreID = "id532105909"
    
    let games:[(img: UIImage, name: String, id: String)] = [
        (UIImage(named: "game1.png")!, "Shapes & colors bubble", "id571421198"),
        (UIImage(named: "game2.png")!, "Kids ABC Games", "id635603974"),
        (UIImage(named: "game3.png")!, "Painter Star: Draw and Color", "id452625949"),
        (UIImage(named: "game4.png")!, "Kids Phone Galore", "id532105909")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurePageControl()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMe))
        btniTunes.addGestureRecognizer(tap)
        btniTunes.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedMe()
    {
        let url = URL(string: "itms-apps://itunes.apple.com/app/\(appStoreID)")
        UIApplication.shared.open(url!, options: [:],
                                  completionHandler: {
                                    (success) in
                                    print("Open URL")
        })

    }
    
    func configurePageControl() {
        
        pageControl.numberOfPages = games.count
        pageControl.currentPage = 0

        let currentGame = games[0]
        
        imgToy.image   = currentGame.img
        appStoreID     = currentGame.id
        labelName.text = currentGame.name
        
        pageControl.addTarget(self, action: #selector(pageControlValueDidChange(sender:)), for: .touchUpInside)
        
    }

    func pageControlValueDidChange(sender:UIPageControl) {
        print("The page control changed its current page to \(sender.currentPage).")
        
        let currentGame = games[sender.currentPage]
        
        imgToy.image   = currentGame.img
        appStoreID     = currentGame.id
        labelName.text = currentGame.name
        
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
