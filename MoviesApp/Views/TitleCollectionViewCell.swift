//
//  TitleCollectionViewCell.swift
//  MoviesApp
//
//  Created by Ruslan on 15.05.2022.
//

import UIKit

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
        configurePosterImageView()
    }
    
    // MARK: - Methods
    private func configurePosterImageView() {
        posterImageView.frame = contentView.bounds
    }
}
