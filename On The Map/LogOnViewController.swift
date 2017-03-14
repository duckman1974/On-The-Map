//
//  LogOnViewController.swift
//  On The Map
//
//  Created by Candice Reese on 3/12/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import UIKit

class LogOnViewController: UIViewController, UITextFieldDelegate {
    
    
    var session: URLSession!
    var appDelegate: AppDelegate!
    
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var logInText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = URLSession.shared
        
        /* Get the app delegate */
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //logInText.text = "LOG IN TO UDACITY"
       
    }
    
    
    
    @IBAction func logIn(_ sender: AnyObject) {
        
        if((userName.text!.isEmpty) || (passWord.text!.isEmpty)) {
            
            print("Username or Password is empty")
            
        } else {
            
            let email = userName.text!
            let password = passWord.text!
            //print(email)
            //print(password)
            
            UdacityClient.sharedInstance().logInToUdacity(email: email, password: password, completionHandler: logInSucceeded)
            
            
        }
    }
    
        func logInSucceeded(success: Bool, result: AnyObject?, error: NSError?) -> Void {
            if success {
                print("successful")
                
            } else {
                print("Not successful")
            }
        }
}


