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
    
    @IBOutlet weak var nickname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().signInAnonymously(completion: nil)
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                self.getAppName()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goPage2":
            let nextVC = segue.destination as! Page2ViewController
            nextVC.nickname = nickname.text!
        default:
            break
        }
    }

    func getAppName(){
        let ref = Database.database().reference()
        ref.child("app").child("name").observe(.value) {  (snapshot) in
            self.appNameLabel.text = snapshot.value as? String
        }
        
//        
//        ref.child("app").child("loginTime").childByAutoId().setValue(ServerValue.timestamp())
//        
        
    }
    @IBAction func goNextPage(_ sender: Any) {
        print("click next Page")
        
//        let nicknameString = nickname.text
        
        guard let nicknameString = nickname.text else{
            return
        }
        
        if nicknameString.count <= 3 {
            alertToUser(message: "請輸入三個字以上的字元")
            return
        }
        
        if appNameLabel.text == "未登入"{
            alertToUser(message: "請檢查網路")
            return
        }
        
        performSegue(withIdentifier: "goPage2", sender: self)
        
        
    }
}

