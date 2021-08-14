import Foundation

@discardableResult
public func timeCheck(_ block: () -> Void) -> TimeInterval {
    let start = Date()
    
    block()
    
    let end = Date().timeIntervalSince(start)
    
    print("🕐 The whole progress time interval: \(end)")
    
    print("==============================")
    
    return end
}
