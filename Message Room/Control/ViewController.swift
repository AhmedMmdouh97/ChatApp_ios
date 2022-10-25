//
//  ViewController.swift
//  Message Room
//
//  Created by Ahmed Mamdouh on 30/10/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var nameAppL: UILabel!
    @IBOutlet weak var lodinL: UIButton!
    @IBOutlet weak var signUpL: UIButton!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var labelEnd: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        radius()
        Timer_delay()
        gatogr()
    }
    func gatogr() {
        let Dataref = Database.database().reference()
        let room = Dataref.child("Gatogr").childByAutoId()
        let DataArray :[String:Any] = ["rooms":"iphone"]
        room.setValue(DataArray) { erro, ref in
            if erro == nil {
                print("sss")
            }
        }
    }
    func radius() {
        endView.layer.cornerRadius = endView.frame.size.height / 1.3
        lodinL.layer.cornerRadius = lodinL.frame.size.height / 2
        signUpL.layer.cornerRadius = signUpL.frame.size.height / 2
    }
    func Timer_delay() {
        nameAppL.text = ""
        var index = 0.0
        let titleText = "Message Room"
        for ietm in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * index , repeats: false) { timer in
                    self.nameAppL.text?.append(ietm)
                }
                index += 1
            }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        
    }
    
}

