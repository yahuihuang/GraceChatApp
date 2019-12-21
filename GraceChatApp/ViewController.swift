//
//  ViewController.swift
//  GraceChatApp
//
//  Created by grace on 2019/12/21.
//  Copyright © 2019 grace. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().signInAnonymously { (user, error) in
            if error == nil {
                self.status.text = "已完成登入"
            } else {
                self.status.text = "登入錯誤"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func enterDisc(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            return
        }
        
        let myNickName = nickName.text ?? ""
        if myNickName.count < 3 {
            showAlert("名字需大於3個字元")
            return
        }
        
        performSegue(withIdentifier: "goList", sender: self)
    }
    
}

extension UIViewController {
    func showAlert(_ msg: String) {
        let alert = UIAlertController(title: "注意", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "收到", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
