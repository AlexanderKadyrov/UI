import Foundation
import Combine
import UIKit

final public class DataSource: UICollectionViewDiffableDataSource<Int, CellViewModel> {
    
    private var cancellables: [AnyCancellable] = []
    
    public var viewModel: DataSourceViewModel? {
        didSet {
            bind()
        }
    }
    
    public init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, viewModel in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier, for: indexPath) as? (any CellView)
            cell?.configure(viewModel: viewModel)
            return cell
        }
    }
    
    private func bind() {
        viewModel?.snapshotPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] snapshot in
                guard let self else { return }
                apply(snapshot)
            }
            .store(in: &cancellables)
    }
}
