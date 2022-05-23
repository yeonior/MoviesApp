//
//  UpcomingViewController.swift
//  MoviesApp
//
//  Created by Ruslan on 13.05.2022.
//

import UIKit

final class UpcomingViewController: UIViewController {
    
    // MARK: - Properties
    private var titles: [Title] = []
    
    // MARK: - Subviews
    private let upcomingTableView: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUpcomingTableViewFrame()
    }
    
    // MARK: - Methods
    private func configureUI() {
        title = "Upcoming"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTableView)
        upcomingTableView.dataSource = self
        upcomingTableView.delegate = self
    }
    
    private func configureUpcomingTableViewFrame() {
        upcomingTableView.frame = view.bounds
    }
    
    private func fetchUpcoming() {
        guard let url = URL(string: Constants.upcomingMoviesURL) else { return }
        NetworkManager.shared.request(fromURL: url) { [weak self] (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let titles):
                self?.titles = titles.results
                DispatchQueue.main.async {
                    self?.upcomingTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension UpcomingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        print(indexPath.row)
        cell.configure(with: TitleViewModel(titleName: (title.originalTitle ?? title.originalName) ?? "N/A", posterURL: title.posterPath ?? ""))
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UpcomingViewController: UITableViewDelegate {
    
}
