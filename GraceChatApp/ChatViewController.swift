//
//  ChatViewController.swift
//  GraceChatApp
//
//  Created by grace on 2019/12/21.
//  Copyright © 2019 grace. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var forumArray:[String] = []
    var dbRef:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = Database.database().reference()
        tableView.delegate = self
        tableView.dataSource = self
        
        dbRef.child("subject").observeSingleEvent(of: .value) { (snapshot) in
            self.forumArray.removeAll()
            
            print(snapshot)
            for snapshotItem in snapshot.children {
                print(snapshotItem)
                if let item = snapshotItem as? DataSnapshot {
                    var subject = item.childSnapshot(forPath: "subject").value as! String
                    self.forumArray.append(subject)
//                    for snapshotItem2 in item.children {
//                        print(snapshotItem2)
//                        if let item2 = snapshotItem2 as? DataSnapshot {
//                            print("item2=> \(item2.key): \(item2.value as? String ?? "")")
//                        }
//                    }
                }
            }
            print(self.forumArray)
            self.tableView.reloadData()
        }
        
        dbRef.child("subject").observe(.value) { (snapshot) in
            self.forumArray.removeAll()
            for snapshotItem in snapshot.children {
                if let item = snapshotItem as? DataSnapshot {
                    var subject = item.childSnapshot(forPath: "subject").value as! String
                    self.forumArray.append(subject)
                }
            }
                        
            self.tableView.reloadData()
        }
    }
    
    //MARK: tableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! DiscListTableViewCell
        cell.title.text = forumArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goDiscList", sender: self)
    }

}
