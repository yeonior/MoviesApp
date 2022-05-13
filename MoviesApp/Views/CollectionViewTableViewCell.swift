//
//  CollectionViewTableViewCell.swift
//  MoviesApp
//
//  Created by Ruslan on 13.05.2022.
//

import UIKit

final class CollectionViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "collectionViewTableViewCell"
    
    // MARK: - Subviews
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemMint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
