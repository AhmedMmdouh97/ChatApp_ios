//
//  loginViewController.swift
//  Message Room
//
//  Created by Ahmed Mamdouh on 30/10/2021.
//

import UIKit
import Firebase
import FirebaseAnalytics
class loginViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radui()
        // Do any additional setup after loading the view.
        
    }

    func radui()  {
        firstView.layer.cornerRadius = firstView.frame.size.height / 20
        loginbutton.layer.cornerRadius = loginbutton.frame.size.height / 2
    }

    @IBAction func loginButton(_ sender: UIButton) {
        guard let emaill = email.text , let passwordd = password.text else {
            return
        }
        Auth.auth().signIn(withEmail: emaill, password: passwordd) { ruslt, errol in
            if errol == nil{
                //print(ruslt)
            }else{
                self.dispalyErrol(erroltext: "worng check your email")
            }
        }
    }
    func dispalyErrol(erroltext:String)  {
        let arlet = UIAlertController.init(title: "Errol", message: erroltext, preferredStyle: .alert)
        let dissmsbutton = UIAlertAction.init(title: "dissms", style: .default, handler: nil)
        arlet.addAction(dissmsbutton)
        present(arlet, animated: true, completion: nil)
    }
}
