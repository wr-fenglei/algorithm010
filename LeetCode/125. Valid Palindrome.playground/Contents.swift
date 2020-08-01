/*:
 [125. Valid Palindrome](https://leetcode.com/problems/valid-palindrome/)
 
 Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
 
 **Note:** For the purpose of this problem, we define empty string as valid palindrome.
 
 ```
 Input: "A man, a plan, a canal: Panama"
 Output: true
 ```
 
 ```
 Input: "race a car"
 Output: false
 ```
 
 **Constraints:** `s` consists only of printable ASCII characters.
 */


import Foundation

/**
 O(n)
 */
class Solution1 {
    func isPalindrome(_ s: String) -> Bool {
        if s.isEmpty { return true }
        let t = s.replacingOccurrences(of: "[^A-Za-z0-9]+", with: "", options: [.regularExpression]).lowercased()
        return String(t.reversed()) == t
    }
}

/**
 O(n)
 */
class Solution2 {
    func isPalindrome(_ s: String) -> Bool {
        if s.isEmpty { return true }
        let t = s.replacingOccurrences(of: "[^A-Za-z0-9]+", with: "", options: [.regularExpression]).lowercased()
        let l = Array(t)
        
        var j = 0, k = l.count - 1
        while j < k {
            if l[j] != l[k] { return false }
            j += 1
            k -= 1
        }
        return true
    }
}

/**
 O(n)
 */
class Solution3 {
    func isPalindrome(_ s: String) -> Bool {
        if s.isEmpty { return true }
        let s = s.lowercased()
        var j = s.startIndex, k = s.index(before: s.endIndex)
        while j < k {
            if !s[j].isLetter, !s[j].isNumber { j = s.index(after: j); continue }
            if !s[k].isLetter, !s[k].isNumber { k = s.index(before: k); continue }
            if s[k] != s[j] { return false }
            j = s.index(after: j)
            k = s.index(before: k)
        }
        return true
    }
}

/**
 O(n)
 */
class Solution4 {
    func isPalindrome(_ s: String) -> Bool {
        
        var mark = Array.init(repeating: 0, count: 256)
        for i in 0..<10 {
            mark[Int("0".utf8CString.first!) + i] = 1 + i // mark[48 + i] = 1 + i
        }
        for i in 0..<26 {
            mark[Int("A".utf8CString.first!) + i] = 11 + i // mark[65 + i] = 11 + i
            mark[Int("a".utf8CString.first!) + i] = 11 + i // mark[97 + i] = 11 + i
        }
        
        let chars = s.utf8CString
        
        var j = 0, k = chars.count - 2
        while j < k {
            let mj = mark[Int(chars[j])]
            let mk = mark[Int(chars[k])]
            if mj != 0, mk != 0 {
                if mj != mk { return false }
                j += 1
                k -= 1
            } else {
                if mj == 0 { j += 1 }
                if mk == 0 { k -= 1 }
            }
        }
        return true
    }
}

//let input = "A man, a plan, a canal: Panama" // true
//let input = "a." // true
//let input = "race a car" // false
let input = ".," // true
let output = Solution4().isPalindrome(input)
print(output)
