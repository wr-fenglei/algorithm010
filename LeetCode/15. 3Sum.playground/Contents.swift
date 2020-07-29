/*:
 [15. 3Sum](https://leetcode.com/problems/3sum/)
 
 Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0?
 
 Find all unique triplets in the array which gives the sum of zero.
 
 **Note:** The solution set must not contain duplicate triplets.
 
 ```
 Given array nums = [-1, 0, 1, 2, -1, -4],
 
 A solution set is:
 [
 [-1, 0, 1],
 [-1, -1, 2]
 ]
 ```
 */

/**
 O(n^3)
 iterate all cases
 ⚠️ 超出时间限制
 */
class Solution1 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 { return [] }
        var result = [[Int]]()
        
        let sorted = nums.sorted()
        
        for i in 0..<sorted.count - 2 {
            if sorted[i] > 0 { break }
            if i > 0, sorted[i] == sorted[i - 1]  { continue }
            
            for j in (i + 1)..<sorted.count - 1 {
                if j > (i + 1), sorted[j] == sorted[j - 1] { continue }
                
                for k in (j + 1)..<sorted.count {
                    if k > (j + 1), sorted[k] == sorted[k - 1] { continue }
                    
                    if sorted[i] + sorted[j] + sorted[k] == 0 { result.append([sorted[i], sorted[j], sorted[k]]) }
                }
            }
        }
        
        return result
    }
}

/**
 O(n^2)
 iterate all cases, but use cache
 */
class Solution2 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 { return [] }
        var result = [[Int]]()
        
        let sorted = nums.sorted()
        
        var map = [Int: Int]()
        for i in 0..<sorted.count {
            map[sorted[i]] = i
        }
        
        for i in 0..<sorted.count - 2 {
            if sorted[i] > 0 { break }
            if i > 0, sorted[i] == sorted[i - 1] { continue }
            
            for j in (i + 1)..<sorted.count - 1 {
                if j > (i + 1), sorted[j] == sorted[j - 1] { continue }
                
                
                if let k = map[-sorted[i] - sorted[j]], k >= (j + 1), k < sorted.count {
                    result.append([sorted[i], sorted[j], sorted[k]])
                }
            }
        }
        
        return result
    }
}

/**
 O(n^2)
 use 2 sum with first half cache
 */
class Solution3 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 { return [] }
        var result = Set<[Int]>()
        
        let sorted = nums.sorted()
        
        for i in 0..<sorted.count - 2 {
            if sorted[i] > 0 { break }
            if i > 0, sorted[i] == sorted[i - 1] { continue }
            
            let target = -sorted[i]
            var set = Set<Int>()
            
            for j in (i + 1)..<sorted.count {
                if set.contains(target - sorted[j]) {
                    result.insert([sorted[i], sorted[j], target - sorted[j]])
                } else {
                    set.insert(sorted[j])
                }
            }
        }
        
        return result.filter { _ in true }
    }
}


/**
 O(n^2) 比 Solution2 快
 
 i = -4, target (j + k) = 4
 
 (j,k) -4   -1   -1    0    1    2
 
 -4     x
 
 -1     x    x   <t1  <t1  <t1   t1（步骤一：j + k = 1 ，比 4 小，该值为此行最大值，此列第二小值，所以在这一行中找不到更大值了，只能在这一列中找更大值）
 
 -1     x    x    x   <t2  <t2   t2（步骤二：j + k = 1 ，比 4 小，继续在列中找）
 
 0     x    x    x    x   <t3   t3（步骤三：比 4 小）
 
 1     x    x    x    x    x    t4（步骤四：比 4 小）
 
 2     x    x    x    x    x    x
 
 
 i = -1, target (j + k) = 1
 
 (j,k) -4   -1   -1    0    1    2
 
 -4     x
 
 -1     x    x
 
 -1     x    x    x  <=s1 <=s1   s1
 
 0     x    x    x    x    s2 >=s1
 
 1     x    x    x    x    x  >=s1
 
 2     x    x    x    x    x    x
 
 */
class Solution4 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 { return [] }
        var result = [[Int]]()
        
        let sorted = nums.sorted()
        for i in 0..<sorted.count - 2 {
            // A trick to improve performance: once nums[i] > 0, then break.
            // Since the nums is sorted, if first number is bigger than 0, it is impossible to have a sum of 0.
            if sorted[i] > 0 { break }
            // skip the same number, which can only has subset
            if i > 0, sorted[i] == sorted[i - 1]  { continue }
            
            let target = -sorted[i]
            
            var j = i + 1, k = sorted.count - 1
            while j < k {
                let tmp = sorted[j] + sorted[k]
                
                if tmp > target {
                    k -= 1
                    while j < k, sorted[k] == sorted[k + 1] { k -= 1 }
                } else if tmp < target {
                    j += 1
                    while j < k, sorted[j] == sorted[j - 1] { j += 1 }
                } else {
                    result.append([sorted[i], sorted[j], sorted[k]])
                    // 跳过重复
                    j += 1
                    k -= 1
                    
                    // skip the same number
                    while j < k, sorted[j] == sorted[j - 1] { j += 1 }
                    // skip the same number
                    while j < k, sorted[k] == sorted[k + 1] { k -= 1 }
                }
            }
        }
        
        return result
    }
}


//let input: [Int] = []
//let input: [Int] = [-1, 0, 1, 2, -1, -4] // [-4, -1, -1, 0, 1, 2]
let input: [Int] = [-4, -2, 1, -5, -4, -4, 4, -2, 0, 4, 0, -2, 3, 1, -5, 0] // [-5, -5, -4, -4, -4, -2, -2, -2, 0, 0, 0, 1, 1, 3, 4, 4]
let output = Solution4().threeSum(input)
print(output)

// []
// [[-1, -1, 2], [-1, 0, 1]]
// [[-5, 1, 4], [-4, 0, 4], [-4, 1, 3], [-2, -2, 4], [-2, 1, 1], [0, 0, 0]]
