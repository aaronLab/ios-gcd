import Foundation

let queue1 = DispatchQueue(label: "queue1")
queue1.async {
    print("This block of code ran!")
}

let queue2 = DispatchQueue(label: "queue2")

let workItem1 = DispatchWorkItem {
    print("Work item1 ran!", Thread.isMainThread)
}

let workItem2 = DispatchWorkItem {
    print("Work item2 ran!", Thread.isMainThread)
}

/// The code below will be executed `workItem2` on the `main thread`.
workItem1.notify(queue: DispatchQueue.main,
                 execute: workItem2)

queue2.async(execute: workItem1)
