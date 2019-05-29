//
//  ViewController.swift
//  FacebookAPI
//
//  Created by Erdem Meral on 5/13/19.
//  Copyright © 2019 Ibrahim Goktug Gokce. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if(error != nil){
            self.lblStatus.text = error?.localizedDescription
        }
        else if(result!.isCancelled){
            self.lblStatus.text = "Action Cancelled"
        }
        else{
            self.lblStatus.text = "Logged In Successfully"
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        self.lblStatus.text = "User Logged Out"
        
    }
    

    
    @IBOutlet weak var lblStatus: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let btnFBLogin = FBLoginButton()
        btnFBLogin.permissions = ["public_profile","email","user_friends"]
        btnFBLogin.center = self.view.center
        self.view.addSubview(btnFBLogin)
        
        if(AccessToken.current != nil){
            self.lblStatus.text = "Already Logged In"
        }
        else{
            self.lblStatus.text = "Not Logged In"
        }
    }


}

