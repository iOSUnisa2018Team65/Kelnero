//
//  MyTabBar.swift
//  Kelnero
//
//  Created by Panariello Aniello on 16/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class MyTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.items?[0].image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[0].selectedImage = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[1].image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[1].selectedImage = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[2].image = UIImage(named: "order")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[2].selectedImage = UIImage(named: "order")?.withRenderingMode(.alwaysOriginal)
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
