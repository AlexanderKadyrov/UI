import Foundation

open class CellViewModel: Hashable, @unchecked Sendable {
    
    public let cellIdentifier: String
    
    open var id: String {
        return cellIdentifier
    }
    
    public init(cellIdentifier: String) {
        self.cellIdentifier = cellIdentifier
    }
    
    open func hash(into hasher: inout Hasher) {
        hasher.combine(cellIdentifier)
    }
    
    public static func == (lhs: CellViewModel, rhs: CellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
