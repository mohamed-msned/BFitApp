//
//  WorkoutTableViewCell.swift
//  BFit
//
//  Created by mac on 18/01/2022.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var moreInfoBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func moreInfoBtnClicked(_ sender: Any) {
    }
    
}
