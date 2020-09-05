//
//  Page2ViewController.swift
//  a207RTDB
//
//  Created by 申潤五 on 2020/9/5.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
import Firebase

class Page2ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    

    @IBOutlet weak var page2TableView: UITableView!
    var nickname = ""
    
    var subjs:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("nickname is \(nickname)")
        
        page2TableView.delegate = self
        page2TableView.dataSource = self
        
        
        readSubjs()
        
    }
    
    func readSubjs(){
        
        let subRef = Database.database().reference(withPath: "subjs")
        subRef.observeSingleEvent(of: .value) { (snapshot) in
            self.subjs.removeAll()
            for item in snapshot.children{
                if let theItem = item as? DataSnapshot{
                    if let sub = theItem.childSnapshot(forPath: "sub").value as? String{
                        self.subjs.append(sub)
                    }
                }
            }
            self.page2TableView.reloadData()
        }
        
        
        
    }
    
    //MARK:TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = subjs[indexPath.row]
        return cell
    }
    
    
    
}
