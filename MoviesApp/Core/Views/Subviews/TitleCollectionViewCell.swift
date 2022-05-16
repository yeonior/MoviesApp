//
//  TitleCollectionViewCell.swift
//  MoviesApp
//
//  Created by Ruslan on 15.05.2022.
//

import UIKit
import SDWebImage

final class TitleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "titleCollectionViewCell"
    
    // MARK: - Subviews
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configurePosterImageViewFrame()
    }
    
    // MARK: - Methods
    private func configurePosterImageViewFrame() {
        posterImageView.frame = contentView.bounds
    }
    
    public func configurePosterImageView(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + model) else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
