import Foundation
import Combine
import UIKit

final public class CollectionDataSource: UICollectionViewDiffableDataSource<CollectionSectionViewModel, CollectionCellViewModel> {
    
    private var cancellables: [AnyCancellable] = []
    
    public var adapter: CollectionDataSourceAdapter? {
        didSet {
            bind()
        }
    }
    
    public init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, viewModel in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier, for: indexPath) as? (any CollectionCellView)
            cell?.configure(viewModel: viewModel)
            return cell
        }
    }
    
    private func bind() {
        adapter?.refreshSnapshotAction
            .receive(on: DispatchQueue.main)
            .sink { [weak self] snapshot in
                guard let self else { return }
                apply(snapshot)
            }
            .store(in: &cancellables)
    }
}
