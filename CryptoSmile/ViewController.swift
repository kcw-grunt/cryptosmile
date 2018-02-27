//
//  ViewController.swift
//  CryptoSmile
//
//  Created by Kerry Washington on 2/27/18.
//  Copyright © 2018 kerrywashington. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    let captureSession = AVCaptureSession()
    var captureLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var scannedBarcode: UITextView!
    @IBOutlet weak var cameraPreviewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupScanningSession()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.captureSession.startRunning()
    }
    
    // Local method to setup camera scanning session.
    func setupScanningSession() {
        // Set camera capture device to default.
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        var error: NSErrorPointer = nil
//
//
//        //.deviceInputWithDevice(captureDevice, error: error)
//        if let input: AnyObject = try AVCaptureDeviceInput.init(device: captureDevice!) {
//            // Adding input souce for capture session.
//            self.captureSession.addInput(input as! AVCaptureInput)
//        } else {
//            print("Error Getting Camera Input")
//        }
//
//        do {
//            guard let input = try? AVCaptureDeviceInput(device: captureDevice!),
//                let captureSession = self.captureSession else {
//                    print("Error in initializing a device input")
//            }
//
//            if error == nil && (captureSession.canAddInput(input)) {
//                self.captureSession.addInput(input as! AVCaptureInput)
//
//            }
//            catch let error {
//                print(error.localizedDescription)
//            }
        
            
        
        let output = AVCaptureMetadataOutput()
        // Set recognisable barcode types as all available barcodes.
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        // Create a new queue and set delegate for metadata objects scanned
        let dispatchQueue = DispatchQueue(label: "scanQueue")
        output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        // Set output to camera session.
        self.captureSession.addOutput(output)
        
        self.captureLayer = AVCaptureVideoPreviewLayer(session: captureSession) as? AVCaptureVideoPreviewLayer
        self.captureLayer!.frame = self.cameraPreviewView.frame
//        self.captureLayer!.videoGravity = AVLayerVideoGravityResizeAspect
//        self.cameraPreviewView.layer.addSublayer(self.captureLayer)
    }

    
    // AVCaptureMetadataOutputObjectsDelegate method
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // Do your action on barcode capture here:
        var capturedBarcode: String
        
        // Speify the barcodes you want to read
        let supportedBarcodeTypes = [AVMetadataObject.ObjectType.qr]
        
        // In all scanned values..
        for barcodeMetadata in metadataObjects {
            // ..check if it is a suported barcode
            for supportedBarcode in supportedBarcodeTypes {
                
                if supportedBarcode == barcodeMetadata.type {
                    // This is a supported barcode
                    // Note barcodeMetadata is of type AVMetadataObject
                    // AND barcodeObject is of type AVMetadataMachineReadableCodeObject
                    //let barcodeObject = //self.captureLayer!.transformedMetadataObjectForMetadataObject(barcodeMetadata as! AVMetadataObject)
                   // capturedBarcode = (barcodeObject as! AVMetadataMachineReadableCodeObject).stringValue
                    // Got the barcode. Set the text in the UI and break out of the loop.
//
//                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
//                        self.captureSession.stopRunning()
//                        self.scannedBarcode.text = capturedBarcode
//                    })
                    return
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

