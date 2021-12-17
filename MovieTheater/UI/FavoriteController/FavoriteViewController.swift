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
        listFavoriteMovie = MovieManager.shared.fetchMoviesByFavorite()
        favoriteMovieTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let selectedMovieItem = listFavoriteMovie[indexPath.row]
        if editingStyle == .delete {
            MovieManager.shared.update(movie: selectedMovieItem, by: false, in: nil)
            listFavoriteMovie = MovieManager.shared.fetchMoviesByFavorite()
            favoriteMovieTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listFavoriteMovie.count == 0 {
            self.favoriteMovieTableView.setEmptyMessage("No favorite movie item.")
        } else {
            self.favoriteMovieTableView.restore()
        }
        return listFavoriteMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        let movieItem = listFavoriteMovie[indexPath.row]
        cell.setupDisplay(movie: movieItem)
        return cell
    }
}
