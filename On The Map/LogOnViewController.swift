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
        
        logInText.text = "LOG IN TO UDACITY"
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func logIn(_ sender: AnyObject) {
        
            let email = userName.text!
            let password = passWord.text!
            
            UdacityClient.sharedInstance().logInToUdacity(email: email, password: password, completionHandler: logInSucceeded)
            
            
    }
    
    
    func logInSucceeded(success: Bool, result: AnyObject?, error: NSError?) -> Void {
        if success {
                
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
            
            //let test = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController")
            present(controller, animated: true, completion: nil)
                
        } else {
            print("Not successful")
        }
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        userName.resignFirstResponder()
        passWord.resignFirstResponder()
        
        return true
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
        
        if passWord.isFirstResponder
        {
            return keyboardSize!.cgRectValue.height
            
        }
            
        else
        {
            return 0
            
        }
        
    }
    
    
    
    
    
    func keyboardWillShow(_ notification:Notification)
    {
        view.frame.origin.y = getKeyboardHeight(notification: notification as NSNotification) * (-1)
    }
    
    func keyboardWillHide(_ notification:Notification)
    {
        view.frame.origin.y = 0
    }
    
    
    func subscribeToKeyboardNotifications()
    {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications()
    {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}


