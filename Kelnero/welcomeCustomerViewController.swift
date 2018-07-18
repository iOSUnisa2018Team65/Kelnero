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
    
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        if qrCode == "" {
            myLabel.text = "No qrcode"
        }else{
            var str = qrCode
        
            spinner.startAnimating()
            var str = "46da4a3ab2106811eecd8e73ea204468_2"
            var restaurantKey = String(str.split(separator: "_")[0])
            var tableNumber = String(str.split(separator: "_")[1])
            RestaurantModel.getById(idToSearch: restaurantKey) {
                (r, error) in
                if let e = error {
                    DispatchQueue.main.async {
                        self.spinner.stopAnimating()
                        self.restaurantNameLabel.text = "Couln't find info. Please retry scanning QR"
                    }
                }
                else { // SUCCESS
                    var restaurantName = r!.name
                    DispatchQueue.main.async {
                        self.spinner.stopAnimating()
                        self.restaurantNameLabel.text = restaurantName
                        self.tableLabel.text = "You're sitting at table " + tableNumber
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Welcome"
        spinner.hidesWhenStopped = true
       restaurantNameLabel.text = ""
        tableLabel.text = ""
        

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
