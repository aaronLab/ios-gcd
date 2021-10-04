import Foundation

class SharedClass {
    lazy var lazyTest = {
        return Int.random(in: 0..<99)
    }()
}

let queue = DispatchQueue(label: "queue", attributes: [.initiallyInactive, .concurrent])
let group = DispatchGroup()
let instance = SharedClass()

for i in 0..<10 {
    group.enter()
    queue.async(group: group) {
        print("id: \(i), var: \(instance.lazyTest)")
        group.leave()
    }
}

group.notify(queue: DispatchQueue.global()) {
    print("Done")
}

queue.activate()
group.wait()
