import Foundation

class SharedClass {
    lazy var lazyTest = {
        return Int.random(in: 0..<100)
    }()
}

class SharedClass2 {
    lazy var lazyTest = {
        return Int.random(in: 0..<100)
    }
}

class SyncSharedClass {
    let queue = DispatchQueue(label: "serial")
    
    lazy var lazyTest = {
        return Int.random(in: 0..<100)
    }()
    
    var readVar: Int {
        queue.sync {
            return lazyTest
        }
    }
}

let queue = DispatchQueue(label: "queue", attributes: [.initiallyInactive, .concurrent])
let group = DispatchGroup()
let instance = SharedClass()

// MARK: - Unsafe

for i in 0..<10 {
    group.enter()
    queue.async(group: group) {
        print("id 1: \(i), var: \(instance.lazyTest)")
        group.leave()
    }
}

group.notify(queue: DispatchQueue.global()) {
    print("Done")
}

queue.activate()
group.wait()

// MARK: - Thread Safe (Sync)

let instance2 = SyncSharedClass()

for i in 0..<10 {
    group.enter()
    queue.async(group: group) {
        print("id 2: \(i), var: \(instance2.readVar)")
        group.leave()
    }
}

group.notify(queue: DispatchQueue.global()) {
    print("Done")
}

queue.activate()
group.wait()

// MARK: - Barrier

let instance3 = SharedClass2()

for i in 0..<10 {
    group.enter()
    queue.async(group: group, qos: .utility, flags: .barrier) {
        print("id 3: \(i), var: \(instance.lazyTest)")
        group.leave()
    }
}

group.notify(queue: DispatchQueue.global()) {
    print("Done")
}

queue.activate()
group.wait()
