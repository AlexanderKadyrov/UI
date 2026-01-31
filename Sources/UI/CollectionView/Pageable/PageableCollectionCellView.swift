import Combine
import UIKit

final class PageableCollectionCellView: UICollectionViewCell, CollectionCellView {
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = false
        view.startAnimating()
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: PageableCollectionCellViewModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicatorView.startAnimating()
    }
    
    private func configureUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).priority(.defaultHigh),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func configure(viewModel: PageableCollectionCellViewModel) {
        activityIndicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            viewModel.pageable()
        })
    }
}
