//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Ruslan on 13.05.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Subviews
    private let homeFeedTable: UITableView = {
        $0.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureHomeFeedTable()
    }
    
    // MARK: - Methods
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        homeFeedTable.dataSource = self
        homeFeedTable.delegate = self
        view.addSubview(homeFeedTable)
    }
    
    private func configureHomeFeedTable() {
        homeFeedTable.frame = view.bounds
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
