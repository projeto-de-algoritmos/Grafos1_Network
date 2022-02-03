//
//  Stack.swift
//  TowerOfHanoi
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 02/11/19.
//  Copyright © 2019 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class Stack<T> {
    private var elements = [T]()
    
    public var count: Int {
        get {
            return elements.count
        }
    }

    public func push(_ element: T) {
        self.elements.append(element)
    }

    public func pop() -> T? {
        guard !self.elements.isEmpty else { return nil }
        return self.elements.removeLast()
    }

    public func peek() -> T? {
        guard !self.elements.isEmpty else { return nil }
        return self.elements.last!
    }

}
