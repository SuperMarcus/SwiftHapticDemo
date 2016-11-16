//
//  ViewController.swift
//  demohaptic
//
//  Created by Marcus Zhou on 9/10/16.
//  Copyright © 2016 Marcus. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var outputLabel: NSTextFieldCell!
    @IBOutlet weak var intervalSlider: NSSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[*] Haptic feedback demo by Marcus");
    }
    
    override func viewWillDisappear() {
        print("[*] Exiting...")
        exit(0)
    }

    @IBAction func onClick(_ obj: NSButton?){
        print("[*] Haptic starts!")
        obj?.isEnabled = false
        outputLabel.title = "Put your fingur on the trackpad to feel the haptic\nChange the value of the slider below to modify interval between haptics"
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        let slider = intervalSlider
        backgroundQueue.async(execute: {
            while true {
                DispatchQueue.main.async(execute: { () -> Void in
                    let performer = NSHapticFeedbackManager.defaultPerformer()
                    performer.perform(NSHapticFeedbackPattern.alignment, performanceTime: NSHapticFeedbackPerformanceTime.now)
                })
                usleep(UInt32((slider?.intValue)!))
            }
        })
    }
}

