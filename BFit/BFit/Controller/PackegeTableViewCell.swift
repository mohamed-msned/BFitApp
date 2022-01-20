//
//  PackegeTableViewCell.swift
//  BFit
//
//  Created by mac on 19/01/2022.
//

import UIKit
import Firebase
import SCLAlertView

class PackegeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var packegeTitle: UILabel!
    @IBOutlet weak var packegeTextView: UITextView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    
    var traineeID = ""
    var packageID = ""
    let db = Firestore.firestore()
    var delegate : packageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 15
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    @IBAction func subscribeBtnClicked(_ sender: Any) {
        
        print(traineeID ,  ":)" , packageID )
        
        subscribe()
    }
    
    
    func subscribe(){
        
      
      
        
        
        if Auth.auth().currentUser == nil {
            
            
            let customeAlert = SCLAlertView()
           
            customeAlert.addButton("ok", backgroundColor: UIColor(named: "fixedOrange"), textColor: .gray) {
                
                self.delegate!.noUserRouteToLogin()
            }
            
            customeAlert.showNotice("Please sign ", subTitle: "how come")
            
            
            
            
        }else{
            
            print(Auth.auth().currentUser!.email!)
            db.collection("Trainees").document(Auth.auth().currentUser!.email!).setData([
                
                
                "trainerID" : traineeID,
                "packageID" : packageID
                
                
            ], merge: true, completion: { error in
                
                if error == nil {
                    
                    print("«Subscribed")
                    
                }else{
                    print("NOOOOOO")
                }
                
                
                
            })
            
            
            
            
        }
        
        
        
        
    }
    
    
    
}


protocol packageCellDelegate {
    
    func noUserRouteToLogin()
    
}
