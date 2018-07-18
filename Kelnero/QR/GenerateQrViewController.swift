//
//  GenerateQrViewController.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 17/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class GenerateQrViewController: UIViewController {

    @IBOutlet weak var tableNumberInputField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableNumberInputField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        tableNumberInputField.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func generateQRButtonClicked(_ sender: UIButton) {
        tableNumberInputField.endEditing(true)
        imageView.image = nil
        spinner.startAnimating()
        generateQr()
    }
    
    //NON COLLEGARE OUTLET: funzione di salvataggio non funziona 
    @IBAction func imageViewClicked(_ sender: UITapGestureRecognizer) {
        if imageView.image != nil {
            shareQrImage()
        }
    }
    
    func generateQr() {
        let n = tableNumberInputField.text!
        if n != "" {
            print("Generating Qr")
            IcloudUtils.asyncGetCurrentUserId { (userId, error) in
                if error != nil {
                    print("In Generating QR: error in fetching iCloudId")
                    // ui update must be done in main thread
                    DispatchQueue.main.async {
                        let title = NSLocalizedString("Couldn't generate QR", comment: "GenerateQrViewController_generateQr_errorAlertTitle")
                        let message = NSLocalizedString("Be sure you are connected to the Internet and that you granted Kelnero permission for reading your iCloud info", comment: "GenerateQrViewController_generateQr_errorAlertMessage")
                        let ok = NSLocalizedString("Ok", comment: "GenerateQrViewController_generateQr_errorAlertOk")
                        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
                else {
                    if userId == "NOT_YET" || userId == "DENIED" {
                        print("In Generating QR: error in fetching iCloudId (permission not granted)")
                        // ui update must be done in main thread
                        DispatchQueue.main.async {
                            let title = NSLocalizedString("Kelnero needs your iCloud permission to work", comment: "GenerateQrViewController_generateQr_errorAlertTitle")
                            let message = NSLocalizedString("Please grant permission in Settings", comment: "GenerateQrViewController_generateQr_errorAlertMessage")
                            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    } else { // SUCCESS
                        print("In Generating QR: received iCloudId \(userId)")
                        let qrString = String(userId.dropFirst()) + "_" + n
                        print("In Generating QR: generating \(qrString)")
                        let qrImage = QrCodeUtils.generateQRCodeFromString(from: qrString)
                        // ui update must be done in main thread
                        DispatchQueue.main.async {
                            self.imageView.image = qrImage
                            self.spinner.stopAnimating()
                        }
                    }
                }
            }
        }
        else {
            let title = NSLocalizedString("No number given", comment: "GenerateQrViewController_generateQr_noTableTitle")
            let message = NSLocalizedString("Please enter the number of the table you want to generate QR code for", comment: "GenerateQrViewController_generateQr_noTableMessage")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            spinner.stopAnimating()
            self.present(alert, animated: true)
        }
    }
    
    func shareQrImage() {
        
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        
        /*let image = imageView.image
         // set up activity view controller
         let imageToShare = [ image! ]
         let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
         activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
         // present the view controller
         self.present(activityViewController, animated: true, completion: nil)
         */
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos. NON è VEROOOOOO", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
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
