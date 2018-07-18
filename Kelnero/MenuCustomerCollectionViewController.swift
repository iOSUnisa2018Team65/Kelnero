//
//  MenuCustomerCollectionViewController.swift
//  Kelnero
//
//  Created by Panariello Aniello on 16/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

let restaurant = Restaurant(ownerIcloudId: "_33caratteri", name: "Da Mario", address: "Via Mario Rossi")

let carbonara = Dish(restaurant: restaurant, name: "Carbonara", price: 7, description: "Carbonara bella")
let pizza = Dish(restaurant: restaurant, name: "Pizza", price: 5, description: "Margherita")

let tiramisu = Dish(restaurant: restaurant, name: "Tiramisù", price: 8, description: "Tiramisù buono")

var primiPiatti = [Dish]()
var desserts = [Dish]()

var menu = [
    primiPiatti,
    desserts
]


class MenuCustomerCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        primiPiatti.append(carbonara)
        primiPiatti.append(pizza)
        primiPiatti.append(pizza)
        primiPiatti.append(pizza)
        primiPiatti.append(pizza)
        primiPiatti.append(pizza) //pizza is good

        
        desserts.append(tiramisu)

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return menu.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var returnValue = Int()
        
        if section == 0 {
            returnValue = primiPiatti.count
            
        } else if section == 1 {
            returnValue = desserts.count
            
        }
        
        return returnValue
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MenuCustomerCollectionViewCell

        cell.textLabel.text = "\(menu[indexPath.section][indexPath.row].name) Section: \(indexPath.section)"
        cell.image.image = menu[indexPath.section][indexPath.row].photo

        return cell
    }
    
    // change background color when user touches cell
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
    }
    
    // change background color back when user releases touch
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.darkGray
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 20), height: CGFloat(100))
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
