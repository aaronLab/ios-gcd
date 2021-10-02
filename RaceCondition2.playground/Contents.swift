import Foundation

let person = Person(firstName: "Aaron", lastName: "Lee")

person.changeName(firstName: "Joseph", lastName: "Lee")
person.name

let names = [
    ("Syeda", "Amna"),
    ("Lun", "Kim"),
    ("Joseph", "Lee"),
    ("Aaron", "Lee")
]

let concurrentQueue = DispatchQueue(label: "name.queue", attributes: .concurrent)
let nameChangeGroup = DispatchGroup()

for (index, name) in names.enumerated() {
    
    concurrentQueue.async(group: nameChangeGroup) {
        usleep(UInt32(10_000 * index))
        person.changeName(firstName: name.0, lastName: name.1)
        print("Current Name: \(person.name)")
    }
}

nameChangeGroup.notify(queue: DispatchQueue.global()) {
    print("Last name: \(person.name)")
}

nameChangeGroup.wait()
