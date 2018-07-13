//
//  welcomeCustomerViewController.swift
//  Kelnero
//
//  Created by Panariello Aniello on 13/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class welcomeCustomerViewController: UIViewController {
    var qrCode: String = ""
    @IBOutlet var myLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        myLabel.text = qrCode
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
