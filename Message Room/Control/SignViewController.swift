//
//  SignViewController.swift
//  Message Room
//
//  Created by Ahmed Mamdouh on 30/10/2021.
//

import UIKit
import Firebase
import FirebaseAnalytics
class SignViewController: UIViewController {

    @IBOutlet weak var fristView: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var signinL: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        radui()
        // Do any additional setup after loading the view.
    }
    

    func radui()  {
        fristView.layer.cornerRadius = fristView.frame.size.height / 20
        signinL.layer.cornerRadius = signinL.frame.size.height / 2
    }
    
    @IBAction func signinButton(_ sender: Any) {
        guard let eemail = email.text ,let ppassword = password.text
        else {
            return
        }
        Auth.auth().createUser(withEmail: eemail, password: ppassword) { result, error in
            if error == nil {
                guard let userid = result?.user.uid , let username = self.userName.text
                else {
                    return
                }
                let refrance = Database.database().reference()
                let user = refrance.child("users").child(userid)
                let arrdata:[String : Any] = ["username" : username]
                user.setValue(arrdata)
            }
        }
    }
    
}
