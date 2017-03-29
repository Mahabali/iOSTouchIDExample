//
//  ViewController.swift
//  TestFingerPrint
//
//  Created by Dhilip on 3/28/17.
//  Copyright © 2017 Dhilip. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func authenticateUser() {
        // Get the local authentication context.
        let context = LAContext()
        
        // Declare a NSError variable.
        var error: NSError?
        
        // Set the reason string that will appear on the authentication alert.
        let reasonString = "Authentication is needed to access your notes."
        
        // Check if the device can evaluate the policy.
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: Error?) -> Void  in
                
                if success {
                    print("Success")
                }
                else{
                    // If authentication failed then show a message to the console with a short description.
                    // In case that the error is a user fallback, then show the password alert view.
                    //print(evalPolicyError?.localizedDescription)
                    
                    switch ((evalPolicyError! as NSError).code) {
                        
                    case LAError.systemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        
                    case LAError.userCancel.rawValue:
                        print("Authentication was cancelled by the user")
                        
                    case LAError.userFallback.rawValue:
                        print("User selected to enter custom password")
                    
                        
                    default:
                        print("Authentication failed")
                        
                    }
                }
                
            })
        }
        else{
            // If the security policy cannot be evaluated then show a short message depending on the error.
            switch error!.code{
                
            case LAError.touchIDNotEnrolled.rawValue:
                print("TouchID is not enrolled")
                
            case LAError.passcodeNotSet.rawValue:
                print("A passcode has not been set")
                
            default:
                // The LAError.TouchIDNotAvailable case.
                print("TouchID not available")
            }
            
            // Optionally the error description can be displayed on the console.
            print("\(error?.localizedDescription)")
            
            // Show the custom alert view to allow users to enter the password.
            
        }
    }

}

