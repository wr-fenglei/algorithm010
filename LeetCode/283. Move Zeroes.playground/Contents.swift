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


/// O(n)
class Solution1 {
    func moveZeroes(_ nums: inout [Int]) {
        var j = 0
        for i in 0..<nums.count {
            // j 总是停在 0 的头部，i 要跳到 0 的尾部
            if nums[i] != 0 {
                // 没找到第一个 0 时，一起向后找
                if i != j {
                    // 0 尾部后面的非 0 的值，与 0 的头部交换
                    nums[j] = nums[i]
                    nums[i] = 0
                }
                j += 1
            }
        }
    }
}

/// O(n)
/// ⚠️ 违规了 `without making a copy of the array`
class Solution2 {
    func moveZeroes(_ nums: inout [Int]) {
        let filtered = nums.filter { $0 != 0 }
        nums = filtered + repeatElement(0, count: nums.count - filtered.count)
    }
}

var array = [0, 1, 0, 3, 12]
Solution2().moveZeroes(&array)
print(array)
