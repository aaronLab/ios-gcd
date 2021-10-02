import Foundation

func lazyChangeValue(from variable: inout Int, to newValue: Int) {
    sleep(UInt32.random(in: 1...3))
    variable = newValue
}

var a = 111

/*
 Sync
 */
lazyChangeValue(from: &a, to: 222)
lazyChangeValue(from: &a, to: 333)
lazyChangeValue(from: &a, to: 0)
print("Sync: \(a)")

/*
 Async
 */

let queue = DispatchQueue(label: "serial")

a = 111

queue.async {
    lazyChangeValue(from: &a, to: 222)
}

queue.async {
    lazyChangeValue(from: &a, to: 333)
}

queue.async {
    lazyChangeValue(from: &a, to: 0)
}

print("Async: \(a)")

sleep(10)

print("Sleep After Async: \(a)")
