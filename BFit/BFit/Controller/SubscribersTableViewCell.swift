//
//  SubscribersTableViewCell.swift
//  BFit
//
//  Created by mac on 20/01/2022.
//

import UIKit

class SubscribersTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var traineeNameLbl: UILabel!
    @IBOutlet weak var moreInfoBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCell.clipsToBounds = true
        viewCell.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
    @IBAction func moreInfoBtnClicked(_ sender: Any) {
    }
    
}
