//
//  HomeViewController.swift
//  BFit
//
//  Created by mac on 06/01/2022.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var trainersTableView: UITableView!
    let db = Firestore.firestore()
    var trainers : [Trainer] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        readTrainer()
        print(trainers.count)
//        segmentedControl.backgroundColor = .clear
//        segmentedControl.tintColor = .orange

        
        // Do any additional setup after loading the view.
    }
    func readTrainer() {
        db.collection("Personal Trainers")
            .addSnapshotListener { (querySnapshot, error) in
               
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    self.trainers = []
                    for document in querySnapshot!.documents{
                        let data = document.data()
                        self.trainers.append(Trainer(
                            email:  data["Email"] as? String ?? "_",
                            descriptoin: data["Description"] as? String ?? "_", fullName: data["Full name"] as? String ?? "_", gender: data["Gender"] as? String ?? "_", phoneNumber: data["Phone number"] as? String ?? "_", type: data["Type"] as? String ?? "_", day: data["Day"] as? String ?? "_", month: data["Month"] as? String ?? "_", year: data["Year"] as? String ?? "_", trainerID: data["TrainerID"] as? String ?? "_"))
                    }
                    print(self.trainers.count)
                    DispatchQueue.main.async {
                        self.trainersTableView.reloadData()
                    }
                }
                
            }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trainersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.trainerNameLable.text = trainers[indexPath.row].fullName
        cell.descriptionTextView.text = trainers[indexPath.row].descriptoin
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}


extension HomeViewController : homeTableViewDelegate {
    
    func routeToMoreInfo(index: Int) {
        
        print(trainers[index].fullName)

        let newVc = storyboard?.instantiateViewController(withIdentifier: "MoreInfoViewController") as! MoreInfoViewController
        
        newVc.name = trainers[index].fullName
        newVc.trainerDescription = trainers[index].descriptoin
        newVc.day = trainers[index].day
        newVc.month = trainers[index].month
        newVc.year = trainers[index].year
        newVc.trainerid = trainers[index].trainerID
        newVc.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(newVc, animated: true)
        
        
    }
    
    
    
}
