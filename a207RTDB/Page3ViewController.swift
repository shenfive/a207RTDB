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

    
    
    var nickName = ""
    var key = ""
    var subject = ""
    var msgs:[[String:Any]] = []
    
    
    
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
                    if let msg = theItem.childSnapshot(forPath: "msg").value as? String,
                        let nickname = theItem.childSnapshot(forPath: "nickname").value as? String,
                        let time = theItem.childSnapshot(forPath: "time").value as? Double{
                        let thedata = ["msg":msg,"nickname":nickname,"time":time] as [String : Any]
                        self.msgs.append(thedata)
                        print(nickname)
                    
                    }
                }
            }
            self.msgs.sort { (a, b) -> Bool in
                let theA = a["time"] as! Double
                let theB = b["time"] as! Double
                return theA > theB
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
    
    //MARK: Tableview Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "discCell") as! DiscTableViewCell
        cell.content.text = msgs[indexPath.row]["msg"] as? String
        cell.nickname.text = msgs[indexPath.row]["nickname"] as? String
        return cell
    }
    
    
}
