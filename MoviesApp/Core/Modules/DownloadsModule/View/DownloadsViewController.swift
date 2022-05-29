//
//  DownloadsViewController.swift
//  MoviesApp
//
//  Created by Ruslan on 13.05.2022.
//

import UIKit

final class DownloadsViewController: UIViewController {
    
    // MARK: - Properties
    private var titles: [TitleItem] = []
    
    // MARK: - Subviews
    private let downloadsTableView: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()   
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureDownloadTableViewFrame()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        title = "Downloads"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        
        view.addSubview(downloadsTableView)
        downloadsTableView.dataSource = self
        downloadsTableView.delegate = self
    }
    
    private func configureDownloadTableViewFrame() {
        downloadsTableView.frame = view.bounds
    }
    
    private func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchTitles { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.downloadsTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension DownloadsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (title.originalTitle ?? title.originalName) ?? "N/A", posterURL: title.posterPath ?? ""))
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DownloadsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.originalTitle ?? title.originalName,
              let query = titleName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: APIs.getYoutubeSearchURL(with: query)) else { return }
        NetworkManager.shared.request(fromURL: url) { [weak self] (result: Result<YoutubeSearchResponse, Error>) in
            switch result {
            case .success(let response):
                let youtubeView = response.items[0]
                let vc = PreviewViewController()
                let viewModel = PreviewViewModel(title: titleName, youtubeView: youtubeView, titleOverview: title.overview ?? "")
                vc.configure(with: viewModel)
                self?.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]) { result in
                switch result {
                case .success(()):
                    print("Deleted from database")
                case .failure(let error):
                    print(error)
                }
            }
            titles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
}
