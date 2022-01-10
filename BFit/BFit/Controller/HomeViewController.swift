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
    override func viewDidLoad() {
        super.viewDidLoad()

//        segmentedControl.backgroundColor = .clear
//        segmentedControl.tintColor = .orange

        
        // Do any additional setup after loading the view.
    }
    

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trainersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}
