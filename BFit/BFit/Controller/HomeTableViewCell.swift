//
//  HomeTableViewCell.swift
//  BFit
//
//  Created by mac on 06/01/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var trainerNameLable: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var seeMoreBtn: UIButton!
    @IBOutlet weak var cellView: UIView!
    
    var index = -1
    var delegate : homeTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // see more button
        seeMoreBtn.clipsToBounds = true
        seeMoreBtn.layer.cornerRadius = 10
        
        // view inside the cell
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func seeMoreBtnClicked(_ sender: Any) {
    
        delegate?.routeToMoreInfo(index: index)
        
    }
 
}


protocol homeTableViewDelegate {
    func routeToMoreInfo(index : Int)
}
