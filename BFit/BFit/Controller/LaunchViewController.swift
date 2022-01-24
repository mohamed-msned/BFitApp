//
//  LaunchViewController.swift
//  BFit
//
//  Created by mac on 24/01/2022.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAnimation()
        // Do any additional setup after loading the view.
    }
    
    func configureAnimation() {
            
              let animation = Animation.named("lf30_editor_jxmiglyw")
              let animationView = AnimationView(animation:animation)
              animationView.contentMode = .scaleAspectFill
              animationView.frame = CGRect(x: 0, y: 70, width: 400, height: 400)
              animationView.center = view.center
              view.addSubview(animationView)
              animationView.play()
              animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.8
              DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:{
                  self.performSegue(withIdentifier: "move", sender: self)
              })
          }
}
