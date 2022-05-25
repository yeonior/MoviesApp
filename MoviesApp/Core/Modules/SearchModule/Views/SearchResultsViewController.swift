//
//  SearchResultsViewController.swift
//  MoviesApp
//
//  Created by Ruslan on 24.05.2022.
//

import UIKit

final class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    public var titles: [Title] = []
    
    // MARK: - Subviews
    private let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 8, height: 180)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self,
                                forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionViewFrame()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
    }
    
    private func configureCollectionViewFrame() {
        searchResultsCollectionView.frame = view.bounds
    }
    
    // MARK: - Public methods
    public func reloadCollectionView() {
        searchResultsCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension SearchResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        
        let title = titles[indexPath.row]
        cell.configurePosterImageView(with: title.posterPath ?? "")
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SearchResultsViewController: UICollectionViewDelegate {
    
}
