//
//  AddDishOwnerViewController.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 17/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class AddDishOwnerViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    var image: UIImage!
    var ownerId = "46da4a3ab2106811eecd8e73ea204468"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        nameField.endEditing(true)
        priceField.endEditing(true)
        categoryField.endEditing(true)
        descriptionField.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func imagePressed(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        // we want a square image
        imagePicker.allowsEditing = true
        imagePicker.setEditing(true, animated: true)
        // If the device has a camera, take a picture, otherwise,
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        self.image = image
        // Put that image onto the screen in our image view
        imageView.image = image
        // Take image picker off the screen
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let name = nameField.text
        let price = (priceField.text as! NSString).doubleValue
        let category = categoryField.text
        let description = descriptionField.text
        let image = self.image
        RestaurantModel.getById(idToSearch: ownerId) {
            (fetchedRestaurant, error) in
            if let e = error {
                print(e)
                return
            }
            else {
                let newDish = Dish(restaurant: fetchedRestaurant!, name: name!, price: price, category: category!, description: description!, photo: image!)
                
                DishModel.addNew(dish: newDish) {
                    (dish, error) in
                    if let e = error {
                        print("Error in saving new dish \(dish.name)):")
                        print(e)
                    }
                    else {
                        print("Dish \(dish.name) successfully saved.")
                    }
                }
            }
        }
    }
    
    @IBAction func prova(_ sender: UIButton) {
        DishModel.getAllDishesByRestaurantId(restaurantId: ownerId) {
            (menu, error) in
            if let e = error {
                print(e)
            }
            else {
                menu.forEach() {
                    (lista) in
                    lista.forEach() {
                        (d) in
                        print(d.name + d.category)
                    }
                }
            }
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
