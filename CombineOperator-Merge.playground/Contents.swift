import Combine
import Foundation
import UIKit
var subscriptions = Set<AnyCancellable>()
//merge将两个同类型的消息队列合并成一个消息队列 2023-03-15(Wed) 20:36:39
example(of: "merge(with:)") {
    let publisher1 = PassthroughSubject<String, Never>()
    let publisher2 = PassthroughSubject<String, Never>()
    
    publisher1
        .merge(with: publisher2)
        .sink { value in
            print(value)
        } receiveValue: { value in
            print(value)
        }
        .store(in: &subscriptions)
    
    publisher1.send("a")
    publisher1.send("b")
    publisher2.send("c")
    publisher1.send("d")
    
    publisher1.send(completion: .finished)
    publisher2.send(completion: .finished)
}
/*
 ——— Example of: merge(with:) ———
 a
 b
 c
 d
 finished
 */
