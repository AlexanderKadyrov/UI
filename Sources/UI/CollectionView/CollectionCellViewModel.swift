import Foundation

open class CollectionCellViewModel: Hashable, @unchecked Sendable {
    
    public let cellIdentifier: String
    
    open var id: String {
        return cellIdentifier
    }
    
    public init(cellIdentifier: String) {
        self.cellIdentifier = cellIdentifier
    }
    
    open func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: CollectionCellViewModel, rhs: CollectionCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
