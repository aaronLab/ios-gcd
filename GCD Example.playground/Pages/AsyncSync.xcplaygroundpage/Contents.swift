//: [Previous](@previous)


import Foundation

let queue = DispatchQueue.global()

func task1(type: String) {
    print("\(type) Task 1 Start")
    
    sleep(1)
    
    print("\(type) Task 1 Finished")
}

func task2(type: String) {
    print("\(type) Task 2 Start")
    
    sleep(2)
    
    print("\(type) Task 2 Finished")
}

func task3(type: String) {
    print("\(type) Task 3 Start")
    
    print("\(type) Task  Finished")
}

/*
 Async
 */

queue.async {
    task1(type: "Async")
}

queue.async {
    task2(type: "Async")
}

queue.async {
    task3(type: "Async")
}

/*
 Sync
 */

queue.sync {
    task1(type: "Sync")
}

queue.sync {
    task2(type: "Sync")
}

queue.sync {
    task3(type: "Sync")
}


//: [Next](@next)
