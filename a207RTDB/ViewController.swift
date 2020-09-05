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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref = Database.database().reference()
        ref.child("app").child("name").observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value as! String)
        }
        
    }


}

