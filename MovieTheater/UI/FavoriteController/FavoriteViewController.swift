//
//  FavoriteViewController.swift
//  MovieTheater
//
//  Created by duytran on 10/5/21.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteMovieTableView: UITableView!
    var listFavoriteMovie:[Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavoriteMovieTableView()
        // post, get, put, delete, patch ?
        // 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchFavoriteMovie()
    }
    
    // MARK: - Setup UI
    private func setupFavoriteMovieTableView() {
        favoriteMovieTableView.delegate = self
        favoriteMovieTableView.dataSource = self
        let nib = UINib(nibName: "FavoriteCell", bundle: nil)
        favoriteMovieTableView.register(nib, forCellReuseIdentifier: "FavoriteCell")
    }
    
    // MARK: - Fetch Data from Realm DB
    private func fetchFavoriteMovie() {
        listFavoriteMovie = RealmManager.shared.fetchMoviesByFavorite()
        favoriteMovieTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFavoriteMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        let movieItem = listFavoriteMovie[indexPath.row]
        cell.setupDisplay(movie: movieItem)
        return cell
    }
}
