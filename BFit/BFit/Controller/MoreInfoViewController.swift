//
//  MoreInfoViewController.swift
//  BFit
//
//  Created by mac on 19/01/2022.
//

import UIKit
import Firebase

class MoreInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var packegesTableView: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthdayLable: UILabel!
    
    
    var name = ""
    var trainerDescription = ""
    var day = ""
    var month = ""
    var year = ""
    var trainerid = ""
    let db = Firestore.firestore()
    var packeges : [Packege] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        descriptionTextView.clipsToBounds = true
        descriptionTextView.layer.cornerRadius = 15.0
        descriptionTextView.layer.borderWidth = 2.0
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        descriptionTextView.text = trainerDescription
        
        nameLbl.text = name
        birthdayLable.text = "\(day)/\(month)/\(year)"
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        readTrainer()
    }
    
    func readTrainer() {
        
        
        db.collection("Packeges").whereField("userID", isEqualTo: trainerid).getDocuments { querySnapshot, error in
            
            
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
                    self.packegesTableView.reloadData()
                }
            }
            
            
        }
        
   
    }
    
    
}

extension MoreInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packeges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = packegesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PackegeTableViewCell
        cell.packegeTitle.text = packeges[indexPath.row].name
        cell.packegeTextView.text = packeges[indexPath.row].packegeDescription
        cell.priceLbl.text = packeges[indexPath.row].price
        cell.durationLbl.text = packeges[indexPath.row].duration
        cell.traineeID = packeges[indexPath.row].trainerID
        cell.packageID = packeges[indexPath.row].packegeID
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}


extension MoreInfoViewController : packageCellDelegate {
    
    func noUserRouteToLogin() {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    
}
