//
//  chatViewController.swift
//  Message Room
//
//  Created by Ahmed Mamdouh on 03/11/2021.
//

import UIKit
import Firebase
import Foundation
import FirebaseAnalytics
class chatViewController: UIViewController  {

    @IBOutlet weak var EnterRoom: UITextField!
    @IBOutlet weak var FristTabel: UITableView!
    var roomArray = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        obseveRoom()
    }
    func obseveRoom() {
        let datar = Database.database().reference()
        datar.child("rooms").observe(.childAdded) { (snapshot) in
            if let dataArray = snapshot.value as? [String : Any] {
                if let rooms = dataArray["rooms"] as? String {
                    let room = Room.init(roomid: snapshot.key, roomName: rooms)
                    self.roomArray.append(room)
                    self.FristTabel.reloadData()
                }
            }
        }
    }
    

    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        do {
              try Auth.auth().signOut()
                navigationController?.popToRootViewController(animated: false)
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
    
    @IBAction func GreateButton(_ sender: UIButton) {
        guard let nameRoom = EnterRoom.text , nameRoom.isEmpty == false
        else{
            return
        }
        let Dataref = Database.database().reference()
        let room = Dataref.child("rooms").childByAutoId()
        let DataArray :[String:Any] = ["rooms":nameRoom]
        room.setValue(DataArray) { erro, ref in
            if erro == nil {
                self.EnterRoom.text = ""
            }
        }
    }
    
}
extension chatViewController : UITableViewDataSource , UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let room  = roomArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = room.roomName
        //print(cell)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roomSelect = self.roomArray[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "chatUser") as! chatUserViewController
        vc.room = roomSelect
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            guard let itemdelete = roomArray[indexPath.row].roomName ,let itemid = roomArray[indexPath.row].roomid else{
                print("itemdelete")
                return
            }
            roomArray.remove(at: indexPath.row)
            FristTabel.deleteRows(at: [indexPath], with: .fade)
            Database.database().reference().child("rooms").child(itemdelete).removeValue()
            Database.database().reference().child("rooms").child(itemid).removeValue()
        }
    }
    
}
