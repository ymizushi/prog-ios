//
//  Lang.swift
//  prog
//
//  Created by 水島　雄太 on 2016/12/13.
//  Copyright © 2016年 info.ymizushi. All rights reserved.
//

import Foundation


protocol Evalable {
    func eval() -> Any
}

class Value<T>: Evalable {
    var v: T
    init(v: T) {
        self.v = v
    }
    
    func eval() -> Any {
        return self.v
    }
}

class Str: Value<String> {
}

class Number: Value<Int> {
}

class Nil: Value<String> {
    init() {
        super.init(v: "なし")
    }
    
    override func eval() -> Any {
        return self.v
    }
}



