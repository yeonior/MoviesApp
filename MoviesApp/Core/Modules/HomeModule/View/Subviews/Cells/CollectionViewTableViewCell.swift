//
//  CollectionViewTableViewCell.swift
//  MoviesApp
//
//  Created by Ruslan on 13.05.2022.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func didTapCell(_ cell: CollectionViewTableViewCell, viewModel: PreviewViewModel)
}

final class CollectionViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "collectionViewTableViewCell"
    private var titles: [Title] = []
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    // MARK: - Subviews
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
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
        configureCollectionViewFrame()
    }
    
    // MARK: - Methods
    private func configureUI() {
        contentView.backgroundColor = .systemMint
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func configureCollectionViewFrame() {
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CollectionViewTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        
        if let model = titles[indexPath.row].posterPath {
            cell.configurePosterImageView(with: model)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CollectionViewTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.originalTitle ?? title.originalName,
              let query = titleName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: APIs.getYoutubeSearchURL(with: query)) else { return }
        NetworkManager.shared.request(fromURL: url) { [weak self] (result: Result<YoutubeSearchResponse, Error>) in
            switch result {
            case .success(let response):
                guard let strongSelf = self else { return }
                let youtubeView = response.items[0]
                let viewModel = PreviewViewModel(title: titleName, youtubeView: youtubeView, titleOverview: title.overview ?? "")
                self?.delegate?.didTapCell(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print(error)
            }
        }
    }
}
