import Foundation

class Persion1 {
    
    var name = "Person1"
    
    func task() {
        
        DispatchQueue.global().async {
            sleep(3)
            
            print("Global: \(self.name)")
            
            DispatchQueue.main.async {
                
                print("Main: \(self.name)")
                
            }
            
        }
        
    }
    
    deinit {
        print("Deinit: \(name)")
    }
    
}

func person1Task() {
    let persion1 = Persion1()
    persion1.task()
}

person1Task()

class Persion2 {
    
    var name = "Person2"
    
    func task() {
        
        DispatchQueue.global().async { [weak self] in
            sleep(3)
            
            print("Global: \(self?.name)")
            
            DispatchQueue.main.async {
                
                print("Main: \(self?.name)")
                
            }
            
        }
        
    }
    
    deinit {
        print("Deinit: \(name)")
    }
    
}

func person2Task() {
    let persion2 = Persion2()
    persion2.task()
}

person2Task()
