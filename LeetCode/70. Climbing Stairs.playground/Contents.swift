/*:
 [70. Climbing Stairs](https://leetcode.com/problems/climbing-stairs/)
 
 You are climbing a stair case. It takes n steps to reach to the top.
 
 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
 
 **Note:** Given n will be a positive integer.
 ```
 Input: 2
 Output: 2
 Explanation: There are two ways to climb to the top.
 1. 1 step + 1 step
 2. 2 steps
 ```
 
 ```
 Input: 3
 Output: 3
 Explanation: There are three ways to climb to the top.
 1. 1 step + 1 step + 1 step
 2. 1 step + 2 steps
 3. 2 steps + 1 step
 ```
 
 ```
 Input: 4
 Output: 5
 Explanation: There are three ways to climb to the top.
 1. 1 step + 1 step + 1 step + 1 step
 2. 1 step + 1 steps + 2 steps
 3. 1 step + 2 steps + 1 steps
 4. 2 steps + 1 step + 1 step
 5. 2 steps + 2 steps
 ```
 
 */

/**
 f(4) 分解为
 走一步：f(3) + 走两步：(f2)
 
 f(3) 分解为
 走一步：f(2) + 走两步：f(1)
 
 f(2) 分解为
 走一步：f(1) + 走两步：f(0)
 
 f(2) = 2
 f(1) = 1
 */
class Solution1 {
    func climbStairs(_ n: Int) -> Int {
        if n == 1 { return 1 }
        var cache = [0, 1, 2] + repeatElement(0, count: n - 2)
        return ways(to: n, &cache)
    }
    
    func ways(to n: Int, _ cache: inout [Int]) -> Int {
        if cache[n] > 0 { return cache[n] }
        let result = ways(to: n - 1, &cache) + ways(to: n - 2, &cache)
        cache[n] = result
        return result
    }
}

class Solution2 {
    func climbStairs(_ n: Int) -> Int {
        if n < 3 { return n }
        var ways = [1, 2]
        for _ in 3...n {
            let last2 = ways.removeFirst()
            ways.append(ways.last! + last2)
        }
        return ways.last!
    }
}

class Solution3 {
    func climbStairs(_ n: Int) -> Int {
        if n < 3 { return n }
        var a = 1
        var b = 2
        for _ in 3...n {
            b = b + a
            a = b - a
        }
        return b
    }
}

/// 0ms
class Solution4 {
    func climbStairs(_ n: Int) -> Int {
        if n < 3 { return n }
        var dp = [1, 1, 2]
        for i in 2...n {
            dp[i%3] = dp[(i - 1) % 3] + dp[(i - 2) % 3]
        }
        return dp[n%3]
    }
}

let input = 9
let output = Solution4().climbStairs(input)
print(output)
