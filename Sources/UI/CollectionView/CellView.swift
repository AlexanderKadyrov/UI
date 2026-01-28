import Foundation
import UIKit

public protocol CellView: UICollectionViewCell {
    associatedtype T: CellViewModel
    var viewModel: T? { get set }
    func configure(viewModel: T)
}

extension CellView {
    func configure(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? T else { return }
        self.viewModel = viewModel
        self.configure(viewModel: viewModel)
    }
}
