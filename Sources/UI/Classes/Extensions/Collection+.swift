import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element == CollectionCellViewModel {
    mutating func union(cellViewModels newCellViewModels: [CollectionCellViewModel]) {
        var oldCellViewModels = self
        let difference = newCellViewModels.difference(from: oldCellViewModels)
        for change in difference {
            switch change {
            case .insert(_, let element, _):
                oldCellViewModels.append(element)
            case .remove(_, let element, _):
                oldCellViewModels.removeAll(where: { $0 == element })
            }
        }
        self = oldCellViewModels
    }
}
