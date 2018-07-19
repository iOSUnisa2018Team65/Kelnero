//
//  MyTabBarOwner.swift
//  Kelnero
//
//  Created by Panariello Aniello on 18/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class MyTabBarOwner: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor.red
        
        self.tabBar.items?[0].image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[0].selectedImage = UIImage(named: "menuSelected")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[1].image = UIImage(named: "order")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[1].selectedImage = UIImage(named: "orderSelected")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[2].image = UIImage(named: "setting")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[2].selectedImage = UIImage(named: "settingSelected")?.withRenderingMode(.alwaysOriginal)
        // Do any additional setup after loading the view.
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
