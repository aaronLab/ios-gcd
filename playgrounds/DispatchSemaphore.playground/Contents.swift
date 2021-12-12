import Foundation

let semaphore = DispatchSemaphore(value: 4)
let queue = DispatchQueue.global(qos: .userInitiated)
let group = DispatchGroup()

for i in 1...10 {
    
    group.enter()
    
//    queue.async(group: group) {
    queue.async {
        
        semaphore.wait()
        
        defer {
            group.leave()
            semaphore.signal()
        }
        
        print("started...", i)
        Thread.sleep(until: Date().addingTimeInterval(3))
        print("done!", i)
        
    }
    
}

group.notify(queue: DispatchQueue.main) {
    print("All done!")
}
