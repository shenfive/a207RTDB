//
//  Tools.swift
//  a207RTDB
//
//  Created by 申潤五 on 2020/9/5.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
extension UIViewController{
    func alertToUser(message:String){
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
}
extension String{
    func localize() -> String{
        return NSLocalizedString(self, comment: "")
    }
}

