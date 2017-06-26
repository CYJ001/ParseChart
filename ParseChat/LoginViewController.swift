//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Chanel Johnson on 6/26/17.
//  Copyright © 2017 Chanel Johnson. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var usernameText: UITextField!

    let alertNetworkController = UIAlertController(title: "Error", message: "There was a problem with signing up and logging in", preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        // handle response here.
    }

    @IBAction func loginButton(_ sender: UIButton) {
       
            let username = usernameText.text ?? ""
            let password = passText.text ?? ""
            
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    self.present(self.alertNetworkController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                        print(error.localizedDescription)
                    }
                } else {
                    print("User logged in successfully")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    // display view controller that needs to shown after successful login
                }
            }
        

    }
    @IBAction func signUpButton(_ sender: UIButton) {
       
            let alertController = UIAlertController(title: "Error", message: "Password or Username field is empty", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            let newUser = PFUser()
            if(usernameText.text == "" || passText.text == ""){
                present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
            else{
                newUser.username = usernameText.text
                newUser.password = passText.text
                newUser.signUpInBackground(){ (success: Bool, error: Error?) in
                    if let error = error {
                        self.present(self.alertNetworkController, animated: true) {
                            // optional code for what happens after the alert controller has finished presenting
                            //print(error.localizedDescription)
                        }
                        print(error.localizedDescription)
                    } else {
                        print("Didn't find error")
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        print("Performed segue")
                        print("User Registered successfully")
                        // manually segue to logged in view
                    }
                }
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
