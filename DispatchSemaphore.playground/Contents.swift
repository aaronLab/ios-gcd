import Foundation

let group = DispatchGroup()
let queue = DispatchQueue.global(qos: .userInteractive)

let semaphore = DispatchSemaphore(value: 3)

for i in 1...10 {
    group.enter()
    semaphore.wait()
    
    queue.async(group: group) {
        print("Start \(i)")
        sleep(1)
        print("End \(i)")
        semaphore.signal()
        group.leave()
    }
}

group.notify(queue: DispatchQueue.global()) {
    print("Finished")
}
