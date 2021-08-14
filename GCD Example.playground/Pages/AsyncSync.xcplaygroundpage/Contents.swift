import Foundation

let queue = DispatchQueue.global()

func task1() {
    print("Task 1 Start")
    
    sleep(1)
    
    print("Task 1 Finished")
}

func task2() {
    print("Task 2 Start")
    
    sleep(4)
    
    print("Task 2 Finished")
}

func task3() {
    print("Task 3 Start")
    
    print("Task 3 Finished")
}

func task4() {
    print("Task 4 Start")
    
    sleep(2)
    
    print("Task 4 Finished")
}

//timeCheck {
//
//    queue.async {  // another thread
//        task1()
//    }
//
//    queue.async {  // another thread
//        task2()
//    }
//
//    queue.async {  // another thread
//        task3()
//    }
//    queue.async {  // another thread
//        task4()
//    }
//
//}

//task1()  // thread 1
//task2()  // thread 1
//task3()  // thread 1
//task4()  // thread 1

timeCheck {
    queue.sync {  // another thread
        task1()
    }
    
    queue.sync {  // another thread
        task2()
    }
    
    queue.sync {  // another thread
        task3()
    }
    queue.sync {  // another thread
        task4()
    }
}
