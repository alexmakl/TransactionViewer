//
//  TransactionItemCell.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation
import UIKit

final class TransactionItemCell: UICollectionViewCell {

    static let reuseIdentifier = "TransactionItemCell"

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()

    private let convertedAmountLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ transaction: TransactionViewModel) {
        amountLabel.text = transaction.amount
        convertedAmountLabel.text = transaction.convertedAmount
    }

    // MARK: private

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(amountLabel)
        contentView.addSubview(convertedAmountLabel)

        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        convertedAmountLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            convertedAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            convertedAmountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
