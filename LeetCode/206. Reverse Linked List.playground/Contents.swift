/*:
 [206. Reverse Linked List](https://leetcode.com/problems/reverse-linked-list/)
 
 Reverse a singly linked list.
 
 ```
 Input: 1->2->3->4->5->NULL
 Output: 5->4->3->2->1->NULL
 ```
 
 **Follow up:** A linked list can be reversed either iteratively or recursively. Could you implement both?
 */


/// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    
    public var describtion: String {
        var string = "\(val)"
        var next: ListNode? = self.next
        while let node = next {
            string += "->\(node.val)"
            next = node.next
        }
        return string + "->NULL"
    }
}


/**
 O(n)
 1-2-3-4-5-nil
   2-3-4-5-1-nil
     3-4-5-2-1-nil
       4-5-3-2-1-nil
         5-4-3-2-1-nil
 */
class Solution1 {
    func reverseList(_ head: ListNode?) -> ListNode? {
        // no need to reverse
        if head == nil || head?.next == nil { return head }
        
        var current = head
        var target = head
        
        while target?.next != nil {
            target = target?.next
        }
        
        while current !== target {
            let next = current?.next
            
            current?.next = target?.next
            target?.next = current
            
            current = next
        }
        
        return current
    }
}

/**
O(n)
1-2-3-4-5-nil

       nil<-5
1->2->3->4->5->nil

    nil<-4<-5
1->2->3->4->nil

 nil<-3<-4<-5
1->2->3->nil

nil<-2<-3<-4<-5
  1->2->nil

nil<-1<-2<-3<-4<-5
     1->nil
*/
class Solution2 {
     func reverseList(_ head: ListNode?) -> ListNode? {
        // no need to reverse
        if head == nil || head?.next == nil { return head }
        
        let tail = reverseList(head?.next)
        
        head?.next?.next = head
        head?.next = nil
        
        return tail
    }
}

/**
 O(n)
 1-2-3-4-5-nil
 
 1-nil
 2-1-nil
 3-2-1-nil
 4-3-2-1-nil
 5-4-3-2-1-nil
 */
class Solution3 {
    func reverseList(_ head: ListNode?) -> ListNode? {
        // no need to reverse
        if head == nil || head?.next == nil { return head }
        
        var tail: ListNode?
        
        var current = head
        while current != nil {
            let next = current?.next
            
            current?.next = tail
            tail = current
            
            current = next
        }
        
        return tail
    }
}

let input = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5)))))
let output = Solution3().reverseList(input)
print(output?.describtion ?? "")
