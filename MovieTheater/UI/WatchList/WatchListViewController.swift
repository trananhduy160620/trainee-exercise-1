//
//  WatchListViewController.swift
//  MovieTheater
//
//  Created by duytran on 10/5/21.
//

import UIKit

class WatchListViewController: UIViewController {

    @IBOutlet weak var watchListMovieTableView: UITableView!
    var watchListMovie:[Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavoriteMovieTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchFavoriteMovie()
    }
    
    // MARK: - Setup UI
    private func setupFavoriteMovieTableView() {
        watchListMovieTableView.delegate = self
        watchListMovieTableView.dataSource = self
        let nib = UINib(nibName: "FavoriteCell", bundle: nil)
        watchListMovieTableView.register(nib, forCellReuseIdentifier: "FavoriteCell")
    }
    
    // MARK: - Fetch Data from Realm DB
    private func fetchFavoriteMovie() {
        watchListMovie = RealmManager.shared.fetchMoviesInWatchList()
        watchListMovieTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension WatchListViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchListMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        let movieItem = watchListMovie[indexPath.row]
        cell.setupDisplay(movie: movieItem)
        return cell
    }
}
