//
//  ViewController.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import UIKit

final class TransactionsViewController: UIViewController, UICollectionViewDelegate {

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, TransactionViewModel>!

    var presenter: TransactionsPresenterProtocol!
    var configurator: TransactionsConfiguratorProtocol = TransactionsConfigurator()

    enum Section {
        case main
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        presenter.viewIsReady()
    }
}

// MARK: - TransactionsViewProtocol

extension TransactionsViewController: TransactionsViewProtocol {
    func updateTitle(_ text: String) {
        title = text
    }

    func reloadData(title: String, _ transactions: [TransactionViewModel]) {
        setupHeader(title)
        applySnapshot(transactions)
    }
}

// MARK: - fileprivate extension

fileprivate extension TransactionsViewController {

    func setupUI() {
        configureViews()
        configureConstraints()
        setupDataSource()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground

        setupCollectionView()

        view.addSubview(collectionView)
    }
    
    func setupCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.headerMode = .supplementary
        configuration.showsSeparators = true

        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        
        collectionView.register(TransactionItemCell.self, forCellWithReuseIdentifier: TransactionItemCell.reuseIdentifier)
    }

    func configureConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, TransactionViewModel>(
            collectionView: collectionView
        ) { (collectionView, indexPath, transaction) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TransactionItemCell.reuseIdentifier,
                for: indexPath
            ) as? TransactionItemCell else {
                return UICollectionViewCell()
            }
            cell.configure(transaction)

            return cell
        }
    }

    func setupHeader(_ title: String) {
        let header = UICollectionView.SupplementaryRegistration<TransactionsHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { headerView, _, _ in
            headerView.configure(text: title)
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: header, for: indexPath)
        }
    }

    func applySnapshot(_ transactions: [TransactionViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TransactionViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(transactions)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
