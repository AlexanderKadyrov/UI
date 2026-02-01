import Foundation
import Combine

open class PageableCollectionSectionViewModel: CollectionSectionViewModel, @unchecked Sendable {
    
    private let pageableSubject = PassthroughSubject<Void, Never>()
    public var pageablePublisher: AnyPublisher<Void, Never> {
        return pageableSubject.eraseToAnyPublisher()
    }
    
    open var pageableAvailable: Bool {
        false
    }
    
    public override func append(cellViewModels models: [CollectionCellViewModel]) {
        var newCellViewModels = cellViewModels
        newCellViewModels += models
        appendPageableIfNeeded(cellViewModels: &newCellViewModels)
        super.append(cellViewModels: newCellViewModels)
    }
    
    private func appendPageableIfNeeded(cellViewModels models: inout [CollectionCellViewModel]) {
        models.removeAll { $0 is PageableCollectionCellViewModel }
        guard pageableAvailable else { return }
        models.append(
            PageableCollectionCellViewModel { [weak self] in
                guard let self else { return }
                pageableSubject.send(())
            }
        )
    }
}
