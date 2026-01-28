import Foundation
import Combine
import UIKit

public class DataSourceViewModel {
    
    @Published private var snapshot = NSDiffableDataSourceSnapshot<Int, CellViewModel>()
    var snapshotPublisher: Published<NSDiffableDataSourceSnapshot<Int, CellViewModel>>.Publisher {
        return $snapshot
    }
    
    public var numberOfItems: Int {
        return snapshot.numberOfItems
    }
    
    public init() {
        
    }
    
    public func append(cellViewModels: [CellViewModel], section: Int) {
        var new = snapshot
        new.appendSections([section])
        new.appendItems(cellViewModels, toSection: section)
        snapshot = new
    }
}
