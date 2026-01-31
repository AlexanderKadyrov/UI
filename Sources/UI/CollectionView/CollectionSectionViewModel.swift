import Foundation
import Combine

open class CollectionSectionViewModel: Hashable, @unchecked Sendable {
    
    @Published private(set) var cellViewModels: [CollectionCellViewModel] = []
    
    open var id: String {
        return String(describing: self)
    }
    
    public init() {
        
    }
    
    public func append(cellViewModels: [CollectionCellViewModel]) {
        var oldCellViewModels = self.cellViewModels
        let difference = cellViewModels.difference(from: oldCellViewModels)
        for change in difference {
            switch change {
            case .insert(_, let element, _):
                oldCellViewModels.append(element)
            case .remove(_, let element, _):
                oldCellViewModels.removeAll(where: { $0 == element })
            }
        }
        self.cellViewModels = oldCellViewModels
    }
    
    open func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: CollectionSectionViewModel, rhs: CollectionSectionViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
