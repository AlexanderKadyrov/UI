import Foundation
import Combine
import UIKit

public class CollectionDataSourceAdapter {
    
    @Published private var snapshot = NSDiffableDataSourceSnapshot<Int, CollectionCellViewModel>()
    var snapshotPublisher: Published<NSDiffableDataSourceSnapshot<Int, CollectionCellViewModel>>.Publisher {
        return $snapshot
    }
    
    public var numberOfItems: Int {
        return snapshot.numberOfItems
    }
    
    public init() {
        
    }
    
    public func append(cellViewModels: [CollectionCellViewModel], section: Int) {
        var new = snapshot
        new.appendSections([section])
        new.appendItems(cellViewModels, toSection: section)
        snapshot = new
    }
}
