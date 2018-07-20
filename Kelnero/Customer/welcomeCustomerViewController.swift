//
//  welcomeCustomerViewController.swift
//  Kelnero
//
//  Created by Panariello Aniello on 13/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

public extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

class welcomeCustomerViewController: UIViewController {
    
    var qrCode: String = ""
    var restaurantKey: String = ""
    var tableNumber: String = ""
    var bool: Bool = true
    
    @IBAction func backToQr(_ sender: Any) {
        DispatchQueue.main.async{
            self.dismiss(animated: false, completion: {})
            self.performSegue(withIdentifier: "backToQr", sender: nil)
            
        }
    }
    
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        viewLoadSetup()
    }

    
    func viewLoadSetup(){
        if qrCode == "" {
            restaurantNameLabel.text = "No qrcode"
        }else{
            if bool == true{
                spinner.startAnimating()
                bool = false
            }
            var str = qrCode
            if str.matches("[A-Za-z0-9]{32}_[0-9]") {
            // var str = "46da4a3ab2106811eecd8e73ea204468_2" //used in debug when no qr code available
            restaurantKey = String(str.split(separator: "_")[0])
            tableNumber = String(str.split(separator: "_")[1])
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
                    restaurant = r!
                    DispatchQueue.main.async {
                        self.spinner.stopAnimating()
                        self.image.image = UIImage(named: "table")
                        self.restaurantNameLabel.text = restaurantName
                        self.tableLabel.text = "You're sitting at Table " + self.tableNumber
                        
                    }
                }
                
            }
            }
            else {
                spinner.stopAnimating()
                restaurantNameLabel.text = "Invalid QR code"
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
