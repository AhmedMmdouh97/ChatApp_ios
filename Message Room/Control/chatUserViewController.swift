//
//  chatUserViewController.swift
//  Message Room
//
//  Created by Ahmed Mamdouh on 06/11/2021.
//

import UIKit
import Firebase
import FirebaseAnalytics
class chatUserViewController: UIViewController {

    var room: Room?
    var messageChat = [massage]()
    @IBOutlet weak var tabelViewChat: UITableView!
    @IBOutlet weak var textFiledChat: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        tabelViewChat.separatorStyle = .none
        tabelViewChat.allowsSelection = false
        // Do any additional setup after loading the view.
        obervMessage()
    }
    func obervMessage() {
        guard let roomId = room?.roomid else {
            return
        }
        let dataref = Database.database().reference()
        dataref.child("rooms").child(roomId).child("messages").observe(.childAdded) { (snapshot) in
            if let dataarry = snapshot.value as? [String : Any]{
                guard let nameSend = dataarry["sendName"] as? String , let text = dataarry["chat"] as? String  , let userr = dataarry["userr"] as? String else {
                    return
                }
                let message = massage.init(messageid: snapshot.key, nameuser: nameSend, textchat: text , useridd: userr)
                self.messageChat.append(message)
                self.tabelViewChat.reloadData()
            }
            
        }
    }
    func messageSend(text : String){
        guard let userName = Auth.auth().currentUser?.uid else{
            return
        }
        let dataraf = Database.database().reference()
        let userr = dataraf.child("users").child(userName)
        userr.child("username").observeSingleEvent(of: .value) { (snapshot) in
            if let userrname = snapshot.value {
                if let roomId = self.room?.roomid , let userid = Auth.auth().currentUser?.uid {
                    let dataArray : [String:Any] = ["sendName":userrname , "chat":text , "userr": userid ]
                    let room = dataraf.child("rooms").child(roomId)
                    room.child("messages").childByAutoId().setValue(dataArray) { errol, ref in
                        if errol == nil {
                            self.textFiledChat.text = ""
//                            print("sssssss")
                        }
                    }
                }
            }
        }
    }

    
    @IBAction func sendMess(_ sender: UIButton) {
       
        guard let textChat = textFiledChat.text , textChat.isEmpty == false else {
           // print("ffffff")
            return
        }
        messageSend(text: textChat)
    }
    
}
extension chatUserViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageChat[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatTableViewCell
        cell.NameUser.text = message.nameuser
        cell.textChat.text = message.textchat
        
        if (message.useridd == Auth.auth().currentUser?.uid){
            cell.bubleChat(bb: .outcoming)
        }
        else{
            cell.bubleChat(bb: .incoming)
        }
       
        return cell
    }
    
    
}
