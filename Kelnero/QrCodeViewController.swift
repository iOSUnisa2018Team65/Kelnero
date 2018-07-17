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
    
    @IBOutlet weak var toolBar: UIToolbar!
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var qrCodeFrameView:UIView?
    
    var codeFinal: String! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()   // Cattura in real-time
        
        let deviceDiscoverySession = AVCaptureDevice.default(for: .video) 
        
        guard let captureDevice = deviceDiscoverySession else
        {
            print("Nessuna camera")
            return
            
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch {
            print(error)
            return
        }
        
//        if (captureSession.canAddInput(videoInput)) {
//            captureSession.addInput(videoInput)
//        } else {
//            failed()
//            return
//        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
//        if (captureSession.canAddOutput(metadataOutput)) {    Il collegamento con l'input e captureSession garantisce l'output
        captureSession.addOutput(metadataOutput)
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = view.layer.bounds
//        previewLayer.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(previewLayer)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
   
        qrCodeFrameView = UIView()
        
//        Riquadro verde attorno al codice individuato
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
            view.bringSubview(toFront: toolBar)
            
        }
        
    }
    
//    func failed() {
//        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//        captureSession = nil
//    }
    
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
//        captureSession.stopRunning()
//
//        if let metadataObject = metadataObjects.first {
//            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
//            guard let stringValue = readableObject.stringValue else { return }
//            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//            found(code: stringValue)
//        }
//
//        dismiss(animated: true)
        
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            
            captureSession.stopRunning()
            
            let qrCodeObject = previewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = qrCodeObject!.bounds

            let readValue: String = metadataObj.stringValue!   //<--- da qui si può usare il valore letto
                
            print(readValue)
                
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: readValue)
        }
    }
    
    func found(code: String) {
        print(code)
        codeFinal = code
        
        sleep(UInt32(0.5)) //wait half second
    
        DispatchQueue.main.async{   //makes the main asynchronous
            self.dismiss(animated: false, completion: {})
            self.performSegue(withIdentifier: "welcomeCustomer", sender: nil)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "welcomeCustomer"){
            
            let tvc = segue.destination as! MyTabBar
            let navc = tvc.viewControllers!.first as! UINavigationController
            let vc = navc.viewControllers.first as! welcomeCustomerViewController
            
            vc.qrCode = codeFinal
            print(codeFinal)
            
        }
 
                    
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

