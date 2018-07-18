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
    
    @IBAction func backToQr(_ sender: Any) {
        DispatchQueue.main.async{
            self.dismiss(animated: false, completion: {})
            self.performSegue(withIdentifier: "backToQr", sender: nil)
            
        }
    }
    @IBOutlet var myLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        if qrCode == ""{
            myLabel.text = "No qrcode"
        }else{
        myLabel.text = qrCode
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Welcome"
 
       
        

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
