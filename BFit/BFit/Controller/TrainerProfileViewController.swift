//
//  TrainerProfileViewController.swift
//  BFit
//
//  Created by mac on 10/01/2022.
//

import UIKit

class TrainerProfileViewController: UIViewController {

    @IBOutlet weak var trainerProfileImg: UIImageView!
    @IBOutlet weak var workoutTableView: UITableView!
    @IBOutlet weak var ButtonView: UIView!
    @IBOutlet weak var trainerDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add packege button
        ButtonView.layer.masksToBounds = false
        ButtonView.layer.cornerRadius = ButtonView.frame.width/2
        ButtonView.clipsToBounds = true
        ButtonView.layer.borderWidth = 2.0
        ButtonView.layer.borderColor = #colorLiteral(red: 1, green: 0.6078431373, blue: 0.4392156863, alpha: 1)
        
        //profile image
        trainerProfileImg.image = UIImage(named: "Picture4")
        
        //description text view
    }

}

extension TrainerProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workoutTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrainerProfileTableViewCell
        return cell
    }
    
    
}
