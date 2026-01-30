import Foundation
import Combine

open class CollectionSectionViewModel: Hashable, @unchecked Sendable {
    
    let cellViewModelsSubject = PassthroughSubject<[CollectionCellViewModel], Never>()
    
    open var id: String {
        return String(describing: self)
    }
    
    public func append(cellViewModels: [CollectionCellViewModel]) {
        cellViewModelsSubject.send(cellViewModels)
    }
    
    open func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: CollectionSectionViewModel, rhs: CollectionSectionViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
