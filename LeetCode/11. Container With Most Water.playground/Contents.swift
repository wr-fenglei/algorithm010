/*:
 [11. Container With Most Water](https://leetcode.com/problems/container-with-most-water/)
 
 Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai).
 n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0).
 Find two lines, which together with x-axis forms a container, such that the container contains the most water.
 
 **Note:** You may not slant the container and n is at least 2.
 
 ![The real head of the household?](question_11.jpg)
 The above vertical lines are represented by array [1, 8, 6, 2, 5, 4, 8, 3, 7].
 In this case, the max area of water (blue section) the container can contain is 49.
 
 ```
 Input: [1, 8, 6, 2, 5, 4, 8, 3, 7]
 Output: 49
 ```
 */

/// O(n^2) 枚举
/// ⚠️ LeetCode 超时
class Solution1 {
    func maxArea(_ height: [Int]) -> Int {
        var maxArea = 0
        for i in 0..<height.count - 1 {
            for j in (i + 1)..<height.count {
                let length = j - i
                let height = min(height[i], height[j])
                maxArea = max(maxArea, length * height)
            }
        }
        return maxArea
    }
}

/**
 O(n) 一维数组左右边界 i, j ，向中间收敛
 参考 https://leetcode.com/problems/container-with-most-water/discuss/6099/Yet-another-way-to-see-what-happens-in-the-O(n)-algorithm
   1 2 3 4 5 6
 1 x ------- o
 2 x x - o o o
 3 x x x o | |
 4 x x x x | |
 5 x x x x x |
 6 x x x x x x
 */
class Solution2 {
    func maxArea(_ height: [Int]) -> Int {
        var i = 0
        var j = height.count - 1
        var maxArea = 0
        while i < j {
            // 哪边矮，就移动哪边，因为移动高的那边只会把值减小
            //（最小高度由矮的那边决定了，不可能再高了，移动高的那边只会把长度缩短，而移动矮的那边还是可能出现更大值的）
            // 短板是制约总量的重要因素，所以需要不断的找短板，替换短板，这个过程中会找到最优解
            var minHeight = height[i]
            if height[i] < height[j] {
                i += 1
            } else {
                minHeight = height[j]
                j -= 1
            }
            // 为了减少一次高度比较，事前移动了 i 或 j ，所以计算时要把距离加回去
            maxArea = max(maxArea, (j - i + 1) * minHeight)
        }
        return maxArea
    }
}

let input = [1, 8, 6, 2, 5, 4, 8, 3, 7]
let output = Solution2().maxArea(input)
print(output)
