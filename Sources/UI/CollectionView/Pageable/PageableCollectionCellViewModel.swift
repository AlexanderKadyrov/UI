import Foundation
import Combine

final class PageableCollectionCellViewModel: CollectionCellViewModel, @unchecked Sendable {
    
    private var completionHandler: (() -> Void)
    
    private let content = UUID().uuidString
    
    override var id: String {
        return content
    }
    
    init(completionHandler: @escaping (() -> Void)) {
        self.completionHandler = completionHandler
        super.init(cellIdentifier: "PageableCollectionCellView")
    }
    
    func pageable() {
        completionHandler()
    }
    
    override func hash(into hasher: inout Hasher) {
        hasher.combine(cellIdentifier)
        hasher.combine(content)
        hasher.combine(id)
    }
}
