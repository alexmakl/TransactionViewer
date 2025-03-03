//
//  ViewController.swift
//  TransactionViewer
//
//  Created by Alexander on 03.03.2025.
//

import UIKit

final class ProductsViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, ProductViewModel>!

    var presenter: ProductsPresenterProtocol!
    var configurator: ProductsConfiguratorProtocol = ProductsConfigurator()

    enum Section {
        case main
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)

        setupUI()

        presenter.viewIsReady()
    }
}

// MARK: - UICollectionViewDelegate

extension ProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.productTapped(at: indexPath.item)
    }
}

// MARK: - ProductsViewProtocol

extension ProductsViewController: ProductsViewProtocol {
    func reloadData(_ products: [ProductViewModel]) {
        applySnapshot(products)
    }
}

// MARK: - fileprivate extension

fileprivate extension ProductsViewController {

    func setupUI() {
        configureViews()
        configureConstraints()
        setupNavigationBar()
        setupDataSource()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground

        setupCollectionView()

        view.addSubview(collectionView)
    }
    
    func setupCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = true
//        configuration.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
//            return self?.swipeActionForItem(at: indexPath)
//        }
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        
        collectionView.register(ProductItemCell.self, forCellWithReuseIdentifier: ProductItemCell.reuseIdentifier)
    }

//    func swipeActionForItem(at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
//            guard let self else { return }
//            
//            let task = dataSource.itemIdentifier(for: indexPath)
//            guard let taskID = task?.id else {
//                completionHandler(false)
//                return
//            }
//
//            presenter.deleteTask(taskID: taskID)
//            completionHandler(true)
//        }
//        deleteAction.backgroundColor = UIColor.red
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }

    func configureConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupNavigationBar() {
        title = "Products"
    }

    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ProductViewModel>(
            collectionView: collectionView
        ) { (collectionView, indexPath, product) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductItemCell.reuseIdentifier,
                for: indexPath
            ) as? ProductItemCell else {
                return UICollectionViewCell()
            }
            cell.configure(product)

            return cell
        }
    }

    func applySnapshot(_ products: [ProductViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ProductViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(products)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
