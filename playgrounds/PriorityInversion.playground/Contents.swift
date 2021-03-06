import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let high = DispatchQueue.global(qos: .userInteractive)
let medium = DispatchQueue.global(qos: .userInitiated)
let low = DispatchQueue.global(qos: .background)

let semaphore = DispatchSemaphore(value: 1)

high.async {
    Thread.sleep(forTimeInterval: 2)
    semaphore.wait()
    defer { semaphore.signal() }
    
    print("HIGH")
}

for i in 1...10 {
    medium.async {
        let waitTime = Double(exactly: arc4random_uniform(7))!
        
        print("MEDIUM \(i)")
        Thread.sleep(forTimeInterval: waitTime)
    }
}

low.async {
    semaphore.wait()
    defer { semaphore.signal() }
    print("LOW")
    Thread.sleep(forTimeInterval: 5)
}
