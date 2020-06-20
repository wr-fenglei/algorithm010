/*:
 [283. Move Zeroes](https://leetcode.com/problems/move-zeroes/)
 
 Given an array nums, write a function to move all `0`'s to the end of it while maintaining the relative order of the non-zero elements.
 ```
 Input: [0,1,0,3,12]
 Output: [1,3,12,0,0]
 ```
 **Note:**
 1. You must do this in-place without making a copy of the array.
 2. Minimize the total number of operations.
 */

/// O(n^2)
class Solution1 {
    func moveZeroes(_ nums: inout [Int]) {
        var i = nums.count
        while i > 0 {
            i -= 1
            guard nums[i] == 0 else { continue }
            moveToEnd(at: i, of: &nums)
        }
    }
    
    func moveToEnd(at i: Int, of nums: inout [Int]) {
        guard i < nums.count - 1 else { return }
        //        nums.swapAt(i, i + 1)
        let a = nums[i + 1]
        nums[i + 1] = nums[i]
        nums[i] = a
        moveToEnd(at: i + 1, of: &nums)
    }
}

/// O(n)
class Solution2 {
    /// 非 0 的值，插入到第一个 0 之前
    func moveZeroes(_ nums: inout [Int]) {
        /// 记录第一个 0 的位置
        var j = 0
        for i in 0..<nums.count {
            // 跳过 0 ，寻找非 0
            if nums[i] != 0 {
                // 将非 0 的值，插入到第一个 0 之前
                if i != j {
                    nums[j] = nums[i]
                    nums[i] = 0
                }
                // 第一个 0 的位置被往后移了，或者还没找到第一个 0 的位置
                j += 1
            }
        }
    }
}

/// O(n)
/// 赶气泡：如果把 0 看成水管中的气泡，那么这个问题就变成把水管中的气泡都赶到水管的一头，动作就是手按住水管，从一头撸到另一头（与输液器排气泡不同）
/// 这个过程中:
/// 1. 气泡的头部随着手一起移动
/// 2. 气泡后面的水，跑到气泡前面
/// 3. 气泡后面的气泡，接到气泡的尾部，使气泡越来越长
/// 参考 https://leetcode.com/problems/move-zeroes/discuss/72000/1ms-Java-solution
class Solution3 {
    func moveZeroes(_ nums: inout [Int]) {
        var j = 0
        for i in 0..<nums.count {
            if nums[i] != 0 {
                let a = nums[j]
                nums[j] = nums[i]
                nums[i] = a
                j += 1
            }
        }
    }
}

/*:
 [Removing Air Bubbles from IV Lines (Nursing Skills)](https://www.youtube.com/watch?v=85qfarffaRo)
 */
/// O(n)
/// 输液器排气泡，把排气泡时流出去的液再接回来
/// ⚠️ 这个方法使用了 new array ，违规了
class Solution4 {
    func moveZeroes(_ nums: inout [Int]) {
        var list = [Int]()
        var n = 0
        for i in 0..<nums.count {
            if nums[i] == 0 {
                n += 1
            } else {
                list.append(nums[i])
            }
        }
        for _ in 0..<n {
            list.append(0)
        }
    }
}

/// O(n)
class Solution5 {
    func moveZeroes(_ nums: inout [Int]) {
        let filtered = nums.filter { $0 != 0 }
        nums = filtered + repeatElement(0, count: nums.count - filtered.count)
    }
}

var array = [0, 1, 0, 3, 12]
Solution5().moveZeroes(&array)
print(array)
