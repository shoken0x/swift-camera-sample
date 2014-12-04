//
//  ViewController.swift
//  swift-camera-sample
//
//  Created by Shoken Fujisaki on 6/8/14.
//  Copyright (c) 2014 Shoken Fujisaki. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var stillImageOutput: AVCaptureStillImageOutput!
    var session: AVCaptureSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Start Camera
        self.configureCamera()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureCamera() -> Bool {
        // init camera device
        var captureDevice: AVCaptureDevice?
        var devices: NSArray = AVCaptureDevice.devices()
        
        // find back camera
        for device: AnyObject in devices {
            if device.position == AVCaptureDevicePosition.Back {
                captureDevice = device as? AVCaptureDevice
            }
        }

        if captureDevice != nil {
            // Debug
            println(captureDevice!.localizedName)
            println(captureDevice!.modelID)
        } else {
            println("Missing Camera")
            return false
        }
        
        // init device input
        var error: NSErrorPointer = nil
        var deviceInput: AVCaptureInput = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: error) as AVCaptureInput
        
        self.stillImageOutput = AVCaptureStillImageOutput()
        
        // init session
        self.session = AVCaptureSession()
        self.session.sessionPreset = AVCaptureSessionPresetPhoto
        self.session.addInput(deviceInput as AVCaptureInput)
        self.session.addOutput(self.stillImageOutput)
        
        // layer for preview
        var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(self.session) as AVCaptureVideoPreviewLayer
        previewLayer.frame = self.view.bounds
        self.view.layer.addSublayer(previewLayer)
        
        self.session.startRunning()
        
        return true
    }

}

