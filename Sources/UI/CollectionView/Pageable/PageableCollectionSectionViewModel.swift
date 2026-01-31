import Foundation
import Combine

open class PageableCollectionSectionViewModel: CollectionSectionViewModel, @unchecked Sendable {
    
    private let pageableSubject = PassthroughSubject<Void, Never>()
    public var pageablePublisher: AnyPublisher<Void, Never> {
        return pageableSubject.eraseToAnyPublisher()
    }
    
    public override func append(cellViewModels: [CollectionCellViewModel]) {
        var newCellViewModels = self.cellViewModels
        newCellViewModels.removeAll { $0 is PageableCollectionCellViewModel }
        newCellViewModels += cellViewModels
        newCellViewModels.append(
            PageableCollectionCellViewModel { [weak self] in
                guard let self else { return }
                pageableSubject.send(())
            }
        )
        super.append(cellViewModels: newCellViewModels)
    }
}
