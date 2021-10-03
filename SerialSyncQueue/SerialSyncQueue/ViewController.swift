//
//  ViewController.swift
//  SerialSyncQueue
//
//  Created by Aaron Lee on 2021/10/03.
//

import UIKit

class ViewController: UIViewController {
    
    let person = Person(firstName: "Aaron", lastName: "Lee")
    let names = [
        ("Joseph", "Lee"),
        ("Syeda", "Amna"),
        ("Lun", "Kim"),
        ("Huel Y", "Choi")
    ]
    
    let concurrentQueue = DispatchQueue(label: "viewController.concurrent",
                                        attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
