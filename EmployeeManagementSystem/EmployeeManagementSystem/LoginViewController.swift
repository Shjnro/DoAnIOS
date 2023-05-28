//
//  LoginViewController.swift
//  EmployeeManagementSystem
//
//  Created by CNTT on 5/29/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginIsTapped(_ sender: UIButton) {
        guard let username = UsernameTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        
        if(username == "Admin" && password == "Admin"){
            self.performSegue(withIdentifier: "goToNext", sender: self)
        }
        else{
            let message = "Please re-enter"
            let alert = UIAlertController(title: "Wrong Username or Password", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
