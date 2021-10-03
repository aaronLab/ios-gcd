//
//  Person.swift
//  SerialSyncQueue
//
//  Created by Aaron Lee on 2021/10/03.
//

import Foundation

class Person {
    
    private var firstName: String
    private var lastName: String
    
    var name: String {
        return "\(firstName) \(lastName)"
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    private func randomDelay(max: Double) {
        let second: Double = 1000_000
        let time = Double.random(in: 0...max)
        usleep(useconds_t(time * second))
    }
    
    func changeName(firstName: String, lastName: String) {
        randomDelay(max: 0.2)
        self.firstName = firstName
        randomDelay(max: 1)
        self.lastName = lastName
    }
    
}

class ThreadSafeSyncPerson: Person {
    
    let serialQueue = DispatchQueue(label: "person.serial")
    
    override func changeName(firstName: String, lastName: String) {
        serialQueue.sync {
            super.changeName(firstName: firstName, lastName: lastName)
        }
    }
    
    override var name: String {
        serialQueue.sync {
            return super.name
        }
    }
    
}
