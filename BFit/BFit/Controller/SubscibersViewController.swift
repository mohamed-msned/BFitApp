//
//  SubscibersViewController.swift
//  BFit
//
//  Created by mac on 20/01/2022.
//

import UIKit
import Firebase

class SubscibersViewController: UIViewController {

    let db = Firestore.firestore()
    
    
    @IBOutlet weak var subscriberTableView: UITableView!
    
    var nameArray  : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getTraineesNames()
    }
    
    func getTraineesNames(){
    
        
        db.collection("Trainees").whereField("trainerID", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { querySnapshot, error in
            
            
            if error == nil {
                
                querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                    
                    self.nameArray.append(queryDocumentSnapshot.get("name") as! String)
                    
                    
                })
                
                self.subscriberTableView.reloadData()
                
                
            }
            
            
        }
        
        
    }
    
    

}

extension SubscibersViewController: UITableViewDataSource, UITableViewDelegate{
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return nameArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = subscriberTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubscribersTableViewCell
    
    cell.traineeNameLbl.text = nameArray[indexPath.row]

    return cell
}
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
}
    
}




