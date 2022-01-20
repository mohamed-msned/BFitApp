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
    
    var packeges : [Packege] = []
    var arr: [Trainer] = []
    var userEmail = ""
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        readTrainer()
        
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
    
    func readTrainer() {
        
        
        db.collection("Packeges").whereField("userID", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { querySnapshot, error in
            
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                self.packeges = []
                for document in querySnapshot!.documents{
                    let data = document.data()
                    self.packeges.append(Packege(packegeDescription: data["description"] as? String ?? "_", name: data["name"] as? String ?? "_", duration: data["duration"] as? String ?? "_", price: data["price"] as? String ?? "_", trainerID: data["userID"] as? String ?? "_", packegeID: data["packageID"] as? String ?? "_", day1WorkoutTitle: data["day 1 workout title"] as? String ?? "_", day1Workout: data["day 1 workout description"] as? String ?? "_", day1MealsTitle: data["day 1 meals title"] as? String ?? "_", day1MeaksDescription: data["day 1 meals description"] as? String ?? "_", day2WorkoutTitle: data["day 2 workout title"] as? String ?? "_", day2Workout: data["day 2 workout description"] as? String ?? "_", day2MealsTitle: data["day 2 meals title"] as? String ?? "_", day2MeaksDescription: data["day 2 meals workout"] as? String ?? "_", day3WorkoutTitle: data["day 3 workout title"] as? String ?? "_", day3Workout: data["day 3 workout description"] as? String ?? "_", day3MealsTitle: data["day 3 meals title"] as? String ?? "_", day3MeaksDescription: data["day 3 meals description"] as? String ?? "_", day4WorkoutTitle: data["day 4 workout title"] as? String ?? "_", day4Workout: data["day 4 workout description"] as? String ?? "_", day4MealsTitle: data["day 4 meals title"] as? String ?? "_", day4MeaksDescription: data["day 4 meals description"] as? String ?? "_", day5WorkoutTitle: data["day 5 workout title"] as? String ?? "_", day5Workout: data["day 5 workout description"] as? String ?? "_", day5MealsTitle: data["day 5 meals title"] as? String ?? "_", day5MeaksDescription: data["day 5 meals description"] as? String ?? "_", day6WorkoutTitle: data["day 6 workout title"] as? String ?? "_", day6Workout: data["day 6 workout description"] as? String ?? "_", day6MealsTitle: data["day 6 meals title"] as? String ?? "_", day6MeaksDescription: data["day 6 meals description"] as? String ?? "_", day7WorkoutTitle: data["day 7 workout title"] as? String ?? "_", day7Workout: data["day 7 workout description"] as? String ?? "_", day7MealsTitle: data["day 7 meals title"] as? String ?? "_", day7MeaksDescription: data["day 7 meals description"] as? String ?? "_"))
                }
                print(self.packeges.count)
                DispatchQueue.main.async {
                    self.workoutTableView.reloadData()
                }
            }
            
            
        }
        
   
    }
    
    
    @IBAction func addPackegeBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CreatePackegeViewController") as! CreatePackegeViewController
        nextVC.delegeate = self 
        
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
}

extension TrainerProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packeges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workoutTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrainerProfileTableViewCell
        cell.workoutTitle.text = packeges[indexPath.row].name
        cell.workoutDescription.text = packeges[indexPath.row].packegeDescription
        cell.durationLable.text = packeges[indexPath.row].duration
        cell.priceLable.text = packeges[indexPath.row].price
        return cell
    }
    
    
}


extension TrainerProfileViewController :  updatePackageDelegate {
    func updateTable(newPackage: Packege) {
        packeges.append(newPackage)
        workoutTableView.reloadData()
        
    }
    
    
}
