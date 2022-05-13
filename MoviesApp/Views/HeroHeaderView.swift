//
//  HeroHeaderView.swift
//  MoviesApp
//
//  Created by Ruslan on 13.05.2022.
//

import UIKit

final class HeroHeaderView: UIView {
    
    // MARK: - Subviews
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureHeroImageViewFrame()
    }
    
    // MARK: - Methods
    private func configureUI() {
        addSubview(heroImageView)
    }
    
    private func configureHeroImageViewFrame() {
        heroImageView.frame = bounds
    }
}
