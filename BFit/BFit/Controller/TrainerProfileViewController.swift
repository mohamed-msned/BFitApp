//
//  TrainerProfileViewController.swift
//  BFit
//
//  Created by mac on 10/01/2022.
//

import UIKit
import Firebase

class TrainerProfileViewController: UIViewController {

    @IBOutlet weak var trainerProfileImg: UIImageView!
    @IBOutlet weak var workoutTableView: UITableView!
    @IBOutlet weak var ButtonView: UIView!
    @IBOutlet weak var trainerDescription: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var arr: [Trainer] = []
    var userEmail = ""
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

//        arr.append(Trainer(email: <#T##String#>, descriptoin: <#T##String#>, fullName: <#T##String#>, gender: <#T##String#>, phoneNumber: <#T##String#>, type: <#T##String#>, day: <#T##String#>, month: <#T##String#>, year: <#T##String#>))
        getData()
        
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
    
    @IBAction func saveBrnClicked(_ sender: Any) {
        db.collection("Personal Trainers")
            .document(userEmail)
            .setData([
                "Description": trainerDescription.text!
            ],merge: true) { err in
                if let err = err {
                    print("Error when adding \(err.localizedDescription)")
                }else {
                    print("document added")
                }
            }
    }
    
    func getData() {
        db.collection("Personal Trainers")
            .whereField("TrainerID", isEqualTo: Auth.auth().currentUser!.uid)
            .getDocuments() {
                
                (querySnapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                }else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        self.userEmail = data["Email"] as? String ?? "_"
                        self.trainerDescription.text = data["Description"] as? String ?? "_"
                    }
                }
                
            }
    }
    @IBAction func addPackegeBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CreatePackegeViewController") as! CreatePackegeViewController
        self.present(nextVC, animated: true, completion: nil)
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
