//
//  TitleTableViewCell.swift
//  MoviesApp
//
//  Created by Ruslan on 22.05.2022.
//

import UIKit

final class TitleTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "titleTableViewCell"
    
    // MARK: - Subviews
    private let titlesPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        contentView.addSubview(titlesPosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let titlesPosterImageViewConstraints = [
            titlesPosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titlesPosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titlesPosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            titlesPosterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titlesPosterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    // MARK: - Public methods
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + model.posterURL) else { return }
        titlesPosterImageView.sd_setImage(with: url)
        titleLabel.text = model.titleName
    }
}
