import Foundation

/// The `SKOptionSet` class implements a way to use Swift Enumerations as options. For this to work, the enum has to adapt to the `OKOption` protocol. A `SKOptionSet` can only contain one instance of a particular Element at a time. Enumerations with an associated values are equal, even if the associated values are not.
///
/// - Note : The best way to look for the associated value of a particular Element ('option') is to use a `for case` loop. As Elements can only be contained once in a `SKOptionSet`, this will never run through more than once.
public class SKOptionSet<Element>: ExpressibleByArrayLiteral, Sequence where Element : SKOptions {
    private var options:[Element]
    
    /// Returns an initialized instance of SKOptionSet, containing the given elements.
    public required init(arrayLiteral elements : Element...){
        options = elements
        
        removeDuplicates()
    }
    
    private init(elements: [Element]){
        options = elements
        
        removeDuplicates()
    }
    
    public func makeIterator() -> Array<Element>.Iterator {
        return options.makeIterator()
    }
    
    /**
     Returns a `SKOptionSet` containing the options of both given sets.
    
     - Note : A SKOptionSet can only contain one instance of a particular Element at a time. In the case of overlaps, the right elements override the left ones.
    */
    public static func +(left : SKOptionSet<Element>, right : SKOptionSet<Element>) -> SKOptionSet<Element>{
        return SKOptionSet(elements: left.options + right.options)
    }
    
    /**
     Returns a `SKOptionSet` containing the options of the given set and the additional element.
    
     - Note : A SKOptionSet can only contain one instance of a particular Element at a time. In the case of overlaps, the right elements override the left ones.
    */
    public static func +(left : SKOptionSet<Element>, right : Element) -> SKOptionSet<Element>{
        return SKOptionSet(elements: left.options + [right])
    }
    
    /**
     Adds the elements of the `SKOptionSet` on the right to the left `SKOptionSet`.
    
     - Note : A SKOptionSet can only contain one instance of a particular Element at a time. In the case of overlaps, the right elements override the left ones.
    */
    public static func +=(left:inout SKOptionSet<Element>, right : SKOptionSet<Element>){
        left = left + right
    }
    
    /**
     Adds the element on the right to the left `SKOptionSet`.
    
     - Note : A SKOptionSet can only contain one instance of a particular Element at a time. In the case of overlaps, the right elements override the left ones.
    */
    public static func +=(left:inout SKOptionSet<Element>, right : Element){
        left = left + right
    }
    
    private func removeDuplicates(){
        // TODO: Replace the implementation of this function completely, if possible. Pretty bad style to use the description.
        
        var existingElementDescriptions:[String] = []
        
        for index in (0..<options.count).reversed(){
            let element = options[index]
            
            var string = String(describing: element)
            string = String(string.split(separator: "(").first!)
            if existingElementDescriptions.contains(string){
                options.remove(at: index)
            }else {
                existingElementDescriptions.append(string)
            }
        }
    }
}
