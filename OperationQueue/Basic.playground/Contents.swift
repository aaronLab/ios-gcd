import UIKit

let mainQueue = OperationQueue.main
let backgroundQueue = OperationQueue()

backgroundQueue.addOperation {
    autoreleasepool {
        for i in 0..<10 {
            
            print(i)
            
        }
    }
}


let blockOperation = BlockOperation {
    autoreleasepool {
        for i in 10..<20 {
            print(i)
        }
    }
}

backgroundQueue.addOperation(blockOperation)
