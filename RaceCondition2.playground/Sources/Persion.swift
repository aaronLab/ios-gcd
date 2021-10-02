import Foundation

open class Person {
    
    private var firstName: String
    private var lastName: String
    
    public init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    open func changeName(firstName: String, lastName: String) {
        randomDelay(max: 0.2)
        self.firstName = firstName
        randomDelay(max: 1)
        self.lastName = lastName
    }
    
    open var name: String {
        return "\(firstName) \(lastName)"
    }
    
    private func randomDelay(max: Double) {
        let second: Double = 1000_000
        let time = Double.random(in: 0...max)
        usleep(useconds_t(time * second))
    }
    
}
