import UIKit

func f(_ n: Int) -> Int {
    guard n > 1 else { return n }
    
    let count = n + 1
    var list = [0, 1] + Array(repeating: 1, count: count - 2)
    for i in 2...n {
        list[i] = list[i - 2] + list[i - 1]
    }
    return list[n]
}

func f1(_ n: Int) -> Int {
    guard n > 1 else { return n }
    var a = 0
    var b = 1
    
    for _ in 2...n {
        b = a + b
        a = b - a
    }
    return b
}

func f2(_ n: Int) -> Int {
    guard n > 1 else { return n }
    return f2(n - 1) + f2(n - 2)
}

func f3(_ n: Int) -> Int {
    var result = Array(repeating: 0, count: n + 1)
    return helper(n, &result)
}

func helper(_ n: Int, _ result: inout [Int]) -> Int {
    if n <= 0 { return 0 }
    if n == 1 { return 1 }
    if result[n] != 0 { return result[n] }
    result[n] = helper(n - 1, &result) + helper(n - 2, &result)
    return result[n]
}

// 0 1 1 2 3 5 8 13 21 34 55
for i in 0...10 {
    print(f3(i))
}
