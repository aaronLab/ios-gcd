//
//  ViewController.swift
//  SerialSyncQueue
//
//  Created by Aaron Lee on 2021/10/03.
//

import UIKit

class ViewController: UIViewController {
    
    let threadSafePerson = ThreadSafeSyncPerson(firstName: "Aaron", lastName: "Lee")
    let names = [
        ("Joseph", "Lee"),
        ("Syeda", "Amna"),
        ("Lun", "Kim"),
        ("Huel Y", "Choi")
    ]
    
    let nameChangeGroup = DispatchGroup()
    let concurrentQueue = DispatchQueue(label: "viewController.concurrent",
                                        attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeNames()
    }
    
    private func changeNames() {
        print("Initial Name: \(threadSafePerson.name)")
        print("==================================================")
        
        concurrentQueue.async(group: nameChangeGroup) { [weak self] in
            guard let self = self else { return }
            
            for (index, name) in self.names.enumerated() {
                
                usleep(UInt32(10_000 * index))
                self.threadSafePerson.changeName(firstName: name.0, lastName: name.1)
                
                let firstName = name.0
                let lastName = name.1
                let currentName = self.threadSafePerson.name
                
                print("First: \(firstName), Last: \(lastName), Current: \(currentName)")
                
            }
            
        }
        
        nameChangeGroup.notify(queue: concurrentQueue) { [weak self] in
            guard let self = self else { return }
            
            print("==================================================")
            print("Result Name: \(self.threadSafePerson.name)")
        }
        
    }

}
