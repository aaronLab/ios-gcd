import Foundation

class SharedClass {
    lazy var lazyTest = {
        return Int.random(in: 0..<99)
    }()
}

let queue = DispatchQueue(label: "queue", attributes: [.initiallyInactive, .concurrent])
let group = DispatchGroup()
let instance = SharedClass()

//for i in 0..<10 {
//    group.enter()
//    queue.async(group: group) {
//        print("id: \(i), var: \(instance.lazyTest)")
//        group.leave()
//    }
//}
//
//group.notify(queue: DispatchQueue.global()) {
//    print("Done")
//}
//
//queue.activate()
//group.wait()

class SyncSharedClass {
    let queue = DispatchQueue(label: "serial")
    
    lazy var lazyTest = {
        return Int.random(in: 0..<99)
    }()
    
    var readVar: Int {
        queue.sync {
            return lazyTest
        }
    }
}

let instance2 = SyncSharedClass()

for i in 0..<10 {
    group.enter()
    queue.async(group: group) {
        print("id: \(i), var: \(instance2.readVar)")
        group.leave()
    }
}

group.notify(queue: DispatchQueue.global()) {
    print("Done")
}

queue.activate()
group.wait()

