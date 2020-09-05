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
    

    func getAppName(){
        let ref = Database.database().reference()
        ref.child("app").child("name").observe(.value) {  (snapshot) in
            self.appNameLabel.text = snapshot.value as? String
        }
        
        
        ref.child("app").child("loginTime").childByAutoId().setValue(ServerValue.timestamp())
        
        
    }
    @IBAction func goNextPage(_ sender: Any) {
        print("click next Page")
        
        guard let nicknameString = nickname.text else{
            return
        }
        
        if nicknameString.count <= 3 {
            self.alertToUser(message: "請輸入三個字以上的字元")
            return
        }
        
        if appNameLabel.text == "未登入"{
            alertToUser(message: "請檢查網路")
            return
        }
        
        
        
    }
}
extension UIViewController{
    func alertToUser(message:String){
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
}
