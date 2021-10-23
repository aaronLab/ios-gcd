import Foundation

class CustomOperation: Operation {
    
    let value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    override func main() {
        
        guard !isCancelled else { return }
        
        for i in 0..<value {
            print(i)
            
            if i == value / 2 {
                
            }
        }
        
    }
    
}

let value = 10
let queue = OperationQueue()
let operation = CustomOperation(value: value)

queue.addOperation(operation)

// queue.cancelAllOperations()

operation.completionBlock = {
    
    print("isReady", operation.isReady)
    print("excuting", operation.isExecuting)
    print("finished", operation.isFinished)
    print("cancelled", operation.isCancelled)
    
}
