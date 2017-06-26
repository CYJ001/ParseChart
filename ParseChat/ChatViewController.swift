//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Chanel Johnson on 6/26/17.
//  Copyright © 2017 Chanel Johnson. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var textMessageField: UITextField!

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var chatView: UITableView!
    var textMessages : [PFObject]? = []
    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = PFObject(className: "Message_fbu2017")
        chatMessage["text"] = textMessageField.text ?? ""
        chatMessage["key"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
textMessageField.text = ""
        
    }
       override func viewDidLoad() {
        super.viewDidLoad()
chatView.dataSource = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        chatView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        chatView.estimatedRowHeight = 50
        // Do any additional setup after loading the view.
    }
    func onTimer() {
        // Add code to be run periodically
       let query = PFQuery(className: "Message_fbu2017")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")

        
        
       
        query.findObjectsInBackground(block: { (messages : [PFObject]?, error: Error?) in
        self.textMessages = messages
            self.chatView.reloadData()
        })
                    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return textMessages!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let messageData = textMessages?[indexPath.row]
        let message = messageData?["text"] as! String
        if let user = messageData?["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
cell.messagesLabel.text = message
  return cell
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
