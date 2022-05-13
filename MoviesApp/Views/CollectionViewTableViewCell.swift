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
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCollectionView()
    }
    
    // MARK: - Methods
    private func configureUI() {
        contentView.backgroundColor = .systemMint
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func configureCollectionView() {
        collectionView.frame = contentView.bounds
    }
}

// MARK: - UICollectionViewDataSource
extension CollectionViewTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CollectionViewTableViewCell: UICollectionViewDelegate {
    
}
