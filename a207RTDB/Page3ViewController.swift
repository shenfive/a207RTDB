//
//  Page3ViewController.swift
//  a207RTDB
//
//  Created by 申潤五 on 2020/9/5.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
import Firebase

class Page3ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = msgs[indexPath.row]
        return cell
    }
    
    
    var nickName = ""
    var key = ""
    var subject = ""
    var msgs:[String] = []
    
    
    
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var page3TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("sub:\(subject)\nkey:\(key)\nnickname:\(nickName)")
        self.title = subject
        
        page3TableView.delegate = self
        page3TableView.dataSource = self
        
        let ref = Database.database().reference().child("disc").child(key)
        ref.observe(.value) { (snapshot) in
            self.msgs.removeAll()
            for item in snapshot.children{
                if let theItem = item as? DataSnapshot{
                    if let sub = theItem.childSnapshot(forPath: "msg").value as? String{
                        self.msgs.append(sub)
                    }
                }
            }
            self.page3TableView.reloadData()
        }
        
        
    }
    
    @IBAction func submit(_ sender: Any) {
        let ref = Database.database().reference().child("disc").child(key)
        let message = messageTF.text ?? ""
        if message.count <= 2 {
            alertToUser(message: "至少輸入三個字元")
            return
        }
        
        let theMsgData:[String:Any] = ["time":ServerValue.timestamp(),"nickname":nickName,"msg":message]
        ref.childByAutoId().setValue(theMsgData)
        messageTF.text = ""
    }
    
}
