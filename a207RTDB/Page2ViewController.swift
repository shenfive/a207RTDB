//
//  Page2ViewController.swift
//  a207RTDB
//
//  Created by 申潤五 on 2020/9/5.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
import Firebase

class Page2ViewController: UIViewController {

    var nickname = ""
    
    var subjs:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("nickname is \(nickname)")
        // Do any additional setup after loading the view.
        
        readSubjs()
        
    }
    
    func readSubjs(){
        
        let subRef = Database.database().reference(withPath: "subjs")
        subRef.observeSingleEvent(of: .value) { (snapshot) in
            self.subjs.removeAll()
            for item in snapshot.children{
                if let theItem = item as? DataSnapshot{
                    if let sub = theItem.childSnapshot(forPath: "sub").value as? String{
                        print(sub)
                        self.subjs.append(sub)
                    }
                }
            }
        }
        
        
        
    }
    

}
