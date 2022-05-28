//
//  SearchResultsViewController.swift
//  MoviesApp
//
//  Created by Ruslan on 24.05.2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapItem(_ viewModel: PreviewViewModel)
}

final class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    public var titles: [Title] = []
    public weak var delegate: SearchResultsViewControllerDelegate?
    
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.originalTitle ?? title.originalName,
              let query = titleName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: APIs.getYoutubeSearchURL(with: query)) else { return }
        NetworkManager.shared.request(fromURL: url) { [weak self] (result: Result<YoutubeSearchResponse, Error>) in
            switch result {
            case .success(let response):
                let youtubeView = response.items[0]
                
                let viewModel = PreviewViewModel(title: titleName, youtubeView: youtubeView, titleOverview: title.overview ?? "")
                self?.delegate?.didTapItem(viewModel)
            case .failure(let error):
                print(error)
            }
        }
    }
}
