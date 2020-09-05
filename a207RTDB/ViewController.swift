//
//  ViewController.swift
//  a207RTDB
//
//  Created by 申潤五 on 2020/9/5.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var appNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().signInAnonymously(completion: nil)
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                self.getAppName()
            }
        }
        
    }

    func getAppName(){
        let ref = Database.database().reference()
        ref.child("app").child("name").observeSingleEvent(of: .value) { (snapshot) in
            self.appNameLabel.text = snapshot.value as? String
        }
        
        let time = Date().timeIntervalSince1970
        
        ref.child("app").child("loginTime").setValue("Hello")
        
        
    }

}

