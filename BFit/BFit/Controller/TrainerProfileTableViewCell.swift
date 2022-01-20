//
//  TrainerProfileTableViewCell.swift
//  BFit
//
//  Created by mac on 12/01/2022.
//

import UIKit

class TrainerProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutTitle: UILabel!
    @IBOutlet weak var workoutDescription: UITextView!
//    @IBOutlet weak var durationLable: UILabel!
//    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var durationLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // view inside the cell
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 15

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
