import Foundation
import Combine

open class CollectionSectionViewModel: Hashable, @unchecked Sendable {
    
    @Published private(set) var cellViewModels: [CollectionCellViewModel] = []
    
    open var id: String {
        return String(describing: self)
    }
    
    public init() {
        
    }
    
    public func append(cellViewModels models: [CollectionCellViewModel]) {
        cellViewModels.union(cellViewModels: models)
    }
    
    open func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: CollectionSectionViewModel, rhs: CollectionSectionViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
