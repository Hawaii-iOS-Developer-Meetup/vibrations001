//
//  ViewController.swift
//  vibrations001
//
//  Created by David Neely on 2/16/17.
//  Copyright © 2017 David Neely. All rights reserved.
//

import UIKit

import AudioToolbox

import UIKit

class ViewController: UIViewController {
    
    var currentBuzzIndex = 0 // index for cycling through different kinds of buzzs for iPhone 7

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func buzzPhone(_ sender: Any) {
        
        let kindOfIPhone = determineKindOfPhone()
        
        if(kindOfIPhone == "not iPhone 7") {
            
            buzzPhone()
            
        } else {
            
            buzzPhoneForiPhone7()
        }
    }
    
    // MARK: - Finds out what kind of iOS device is running this code
    
    /// Finds out what kind of iOS device this is.
    /// :param: nothing
    /// :returns: nothing
    func determineKindOfPhone() -> String {
        
        var returnString = ""
        
        returnString = UIDevice.current.modelName
        
        return returnString
    }

    // MARK: - Vibrates Phone for all other devices (not iPhone 7 or iPhone 7s Plus)
    
    /// Buzzes the phone if it's an iPhone 7 or iPhone 7s Plus.
    /// :param: nothing
    /// :returns: nothing
    func buzzPhone() {
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        print("buzzPhone called")
    }
    
    // MARK: - Vibrates Phone with iOS 10 on iPhone 7
    
    /// Buzzes the phone in different patterns on iPhone 7 and iPhone 7s Plus.
    /// :param: nothing
    /// :returns: nothing
    func buzzPhoneForiPhone7() {
        
        print("buzzPhoneForiPhone7 called")
        
        //source: https://www.hackingwithswift.com/example-code/uikit/how-to-generate-haptic-feedback-with-uifeedbackgenerator
        
        currentBuzzIndex += 1
        
        print("Running \(currentBuzzIndex)")
        
        switch currentBuzzIndex {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            currentBuzzIndex = 0
        }
    }
}

// MARK: - Determines the kind of iPhone this code is being run on

/// Determines what kind of device this code is running on.
/// :param: nothing
/// :returns: nothing
public extension UIDevice {
    
    // source: http://stackoverflow.com/questions/26028918/ios-how-to-determine-the-current-iphone-device-model-in-swift#26962452
    
    var modelName: String {
        
        var systemInfo = utsname()
        
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            
            guard let value = element.value as? Int8, value != 0 else {
                
                return identifier
            }
            
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone9,1", "iPhone9,3":
            return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":
            return "iPhone 7 Plus"
        default:
            return "not iPhone 7"
        }
    }
}
