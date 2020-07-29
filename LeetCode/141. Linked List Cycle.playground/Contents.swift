/*:
 [141. Linked List Cycle](https://leetcode.com/problems/linked-list-cycle/)
 
 Given a linked list, determine if it has a cycle in it.
 
 To represent a cycle in the given linked list, we use an integer `pos` which represents the position (0-indexed) in the linked list where tail connects to.
 
 If `pos` is -1, then there is no cycle in the linked list.
 
 ```
 Input: head = [3,2,0,-4], pos = 1
 Output: true
 Explanation: There is a cycle in the linked list, where tail connects to the second node.
 ```
 ![circularlinkedlist](circularlinkedlist.png)
 
 ```
 Input: head = [1,2], pos = 0
 Output: true
 Explanation: There is a cycle in the linked list, where tail connects to the first node.
 ```
 ![circularlinkedlist_test2](circularlinkedlist_test2.png)
 
 ```
 Input: head = [1], pos = -1
 Output: false
 Explanation: There is no cycle in the linked list.
 ```
 ![circularlinkedlist_test3](circularlinkedlist_test3.png)
 
 **Follow up:** Can you solve it using O(1) (i.e. constant) memory?
 */


/// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// O(n^2) 因为 ListNode 没法用 hash
class Solution1 {
    func hasCycle(_ head: ListNode?) -> Bool {
        var nodes = [ListNode]()
        
        var current = head
        while let node = current {
            if nodes.contains(where: { $0 === node }) { return true }
            nodes.append(node)
            current = current?.next
        }
        
        return false
    }
}

// O(n)
// ⚠️ 此方法会破坏原链表
class Solution2 {
    func hasCycle(_ head: ListNode?) -> Bool {
        var current = head
        while current != nil {
            if current?.next === head { return true }
            
            let next = current?.next
            current?.next = head
            current = next
        }
        
        return false
    }
}

/**
 O(n)
 
 if there's a circle, the faster one will finally "catch" the slower one.
 (the distance between these 2 pointers will decrease one every time.)
 
 if there's no circle, the faster runner will reach the end of linked list. (NULL)
 */
class Solution3 {
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil || head?.next == nil { return false }
        
        var walk = head
        var run = head?.next
        while run != nil {
            if walk === run { return true }
            walk = walk?.next
            run = run?.next?.next
        }
        return false
    }
}

let nodes: [ListNode] = [3, 2, 0, -4].map { ListNode($0) }
for i in 0..<nodes.count - 1 {
    nodes[i].next = nodes[i + 1]
}
// cycle
nodes.last?.next = nodes[1]

let input = nodes.first
let output = Solution3().hasCycle(input)
print(output)
