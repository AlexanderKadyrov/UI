import Foundation
import UIKit

public protocol CollectionCellView: UICollectionViewCell {
    associatedtype T: CollectionCellViewModel
    var viewModel: T? { get set }
    func configure(viewModel: T)
}

extension CollectionCellView {
    func configure(viewModel: CollectionCellViewModel) {
        guard let viewModel = viewModel as? T else { return }
        self.viewModel = viewModel
        self.configure(viewModel: viewModel)
    }
}
