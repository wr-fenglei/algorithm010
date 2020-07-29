/*:
 [1. Two Sum](https://leetcode.com/problems/two-sum/)
 
 Given an array of integers, return **indices** of the two numbers such that they add up to a specific target.
 
 You may assume that each input would have **exactly** one solution, and you may not use the same element twice.
 
 
 ```
 Given nums = [2, 7, 11, 15], target = 9,
 
 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 ```
 */

/**
 O(n^2)
 iterate all cases
 */
class Solution1 {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for i in 0..<nums.count - 1 {
            for j in (i + 1)..<nums.count {
                if nums[i] + nums[j] == target { return[i, j] }
            }
        }
        return []
    }
}

/**
 O(n)
 sorted array with left, right point
*/
class Solution2 {
    
    struct Map: Comparable {
        static func < (lhs: Map, rhs: Map) -> Bool {
            return lhs.n < rhs.n
        }
        
        let n: Int
        let i: Int
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        var maps = [Map]()
        for i in 0..<nums.count {
            maps.append(Map(n: nums[i], i: i))
        }
        
        let sorted = maps.sorted()
        
        var j = 0, k = sorted.count - 1
        while j < k {
            let sum = sorted[j].n + sorted[k].n
            if sum > target {
                k -= 1
                while j < k, sorted[k].n == sorted[k + 1].n { k -= 1 }
            } else if sum < target {
                j += 1
                while j < k, sorted[j].n == sorted[j - 1].n { j += 1 }
            } else {
                return [sorted[j].i, sorted[k].i]
            }
        }
        return []
    }
}

/**
 O(n)
 cache all numbers
*/
class Solution3 {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map = [Int: Int]()
        
        for i in 0..<nums.count {
            map[nums[i]] = i
        }
        
        for i in 0..<nums.count {
            // Beware that the complement must not be nums[i] itself!
            if let j = map[target - nums[i]], i != j { return [i, j] }
        }
        
        return []
    }
}

/**
 O(n)
 cache first half numbers
*/
class Solution4 {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map = [Int: Int]()
        
        for i in 0..<nums.count {
            // the complement of nums[i] either in the map, or in the subsequent of the nums.
            // so, when you miss nums[i], you can look back to check by it's complement.
            if let j = map[target - nums[i]] { return [i, j] }
            map[nums[i]] = i
        }
        
        return []
    }
}

//let input = [2, 7, 11, 15]
//let target = 9
let input = [3, 2, 4]
let target = 6
let output = Solution4().twoSum(input, target)
print(output)
