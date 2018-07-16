//
//  qrCodeViewController.swift
//  Kelnero
//
//  Created by Panariello Aniello on 13/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit
import AVFoundation

class qrCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var codeFinal: String! // var to send info in segue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
   
        
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        codeFinal = code
        
        
     sleep(1)
        
//
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let nvc = storyboard.instantiateViewController(withIdentifier: "myTabBar") as! UITabBarController
//        self.present(nvc, animated: true, completion: nil)
       
        
        DispatchQueue.main.async{
            self.dismiss(animated: false, completion: {})
            self.performSegue(withIdentifier: "welcomeCustomer", sender: nil)
            
        }
//        dispatch_async(dispatch_get_main_queue(), {
//            self.dismissViewControllerAnimated(false, completion: {})
//            self.performSegueWithIdentifier("welcomeCustomer", sender: nil)
//        })
//        self.performSegue(withIdentifier: "welcomeCustomer", sender: nil)
//kdjfhliszufgho
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "welcomeCustomer"){
            
            let tvc = segue.destination as! MyTabBar
            let navc = tvc.viewControllers!.first as! UINavigationController
            let vc = navc.viewControllers.first as! welcomeCustomerViewController
            
            vc.qrCode = codeFinal
            
        }
 
                    
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

