//
//  DiscTableViewCell.swift
//  a207RTDB
//
//  Created by 申潤五 on 2020/9/12.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit

class DiscTableViewCell: UITableViewCell {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var nickname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
