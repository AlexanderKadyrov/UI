import UIKit

extension NSDiffableDataSourceSnapshot<CollectionSectionViewModel, CollectionCellViewModel> {
    mutating func apply(cellViewModels newCellViewModels: [CollectionCellViewModel], section: CollectionSectionViewModel) {
        let oldCellViewModels = itemIdentifiers(inSection: section)
        let difference = newCellViewModels.difference(from: oldCellViewModels)
        var snapshot = self
        for change in difference {
            switch change {
            case .insert(_, let element, _):
                snapshot.appendItems([element], toSection: section)
            case .remove(_, let element, _):
                snapshot.deleteItems([element])
            }
        }
        self = snapshot
    }
}
