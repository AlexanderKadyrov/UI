import Foundation
import Combine
import UIKit

public class CollectionDataSourceAdapter {
    
    private var cancellables: [AnyCancellable] = []
    
    @Published private var snapshot = NSDiffableDataSourceSnapshot<CollectionSectionViewModel, CollectionCellViewModel>()
    var refreshSnapshotAction: Published<NSDiffableDataSourceSnapshot<CollectionSectionViewModel, CollectionCellViewModel>>.Publisher {
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
            element.appendCellViewModelsAction
                .receive(on: DispatchQueue.main)
                .sink { [weak self] cellViewModels in
                    guard let self else { return }
                    snapshot.appendItems(cellViewModels, toSection: element)
                }
                .store(in: &cancellables)
        }
    }
}
