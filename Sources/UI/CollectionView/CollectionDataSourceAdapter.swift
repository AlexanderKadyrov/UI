import Foundation
import Combine
import UIKit

public class CollectionDataSourceAdapter {
    
    private var cancellables: [AnyCancellable] = []
    
    @Published private var snapshot = NSDiffableDataSourceSnapshot<CollectionSectionViewModel, CollectionCellViewModel>()
    var snapshotPublisher: Published<NSDiffableDataSourceSnapshot<CollectionSectionViewModel, CollectionCellViewModel>>.Publisher {
        return $snapshot
    }
    
    public var numberOfItems: Int {
        return snapshot.numberOfItems
    }
    
    public init() {
        
    }
    
    public func append(sections: [CollectionSectionViewModel]) {
        snapshot.appendSections(sections)
        for element in sections {
            element.$cellViewModels
                .receive(on: DispatchQueue.main)
                .sink { [weak self] cellViewModels in
                    guard let self else { return }
                    refresh(cellViewModels: cellViewModels, section: element)
                }
                .store(in: &cancellables)
        }
    }
    
    private func refresh(cellViewModels: [CollectionCellViewModel], section: CollectionSectionViewModel) {
        let oldCellViewModels = snapshot.itemIdentifiers(inSection: section)
        let difference = cellViewModels.difference(from: oldCellViewModels)
        var new = snapshot
        for change in difference {
            switch change {
            case .insert(_, let element, _):
                guard new.indexOfItem(element) == nil else { continue }
                new.appendItems([element], toSection: section)
            case .remove(_, let element, _):
                new.deleteItems([element])
            }
        }
        snapshot = new
    }
}
