//
//  WatchListViewController.swift
//  MovieTheater
//
//  Created by duytran on 10/5/21.
//

import UIKit
import RealmSwift

class WatchListViewController: UIViewController {

    @IBOutlet weak var watchListMovieTableView: UITableView!
    var albumMovies:[AlbumMovie] = AlbumMovieManager.shared.fetchAllAlbumMovie()
    var isEnabledDismissButton = (enabled: false, color: UIColor.clear)
    var movie:Movie?
    var movies: List<Movie> = List<Movie>()
    var dataDelegate: DataDelgate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavoriteMovieTableView()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchWatchListMovie()
    }
    
    // MARK: - Setup UI
    private func setupFavoriteMovieTableView() {
        watchListMovieTableView.delegate = self
        watchListMovieTableView.dataSource = self
        watchListMovieTableView.register(AlbumCell.nib, forCellReuseIdentifier: AlbumCell.reuseableIdentifier)
    }
    
    private func setupNavigationBar() {
        self.title = "Watch List"
        let createAllbumButton = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"),
                                                 style: .done, target: self, action: #selector(self.handleCreateAllbum))
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark")?.withTintColor(isEnabledDismissButton.color,
                                                                                               renderingMode: .alwaysOriginal),
                                            style: .done, target: self, action: #selector(self.handleDismiss))
        dismissButton.isEnabled = isEnabledDismissButton.enabled
        self.navigationItem.rightBarButtonItem = createAllbumButton
        self.navigationItem.leftBarButtonItem = dismissButton
    }
    
    @objc func handleCreateAllbum() {
        let alertController = UIAlertController(title: "Create Album",
                                                message: "Add an album in watch list", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter your album"
            textfield.returnKeyType = .done
        }
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let textfields = alertController.textFields else { return }
            let nameAlbumTextfield = textfields[0]
            if let nameAlbum = nameAlbumTextfield.text, !nameAlbum.isEmpty {
                let uuid = UUID()
                let album = Album(id: uuid, name: nameAlbum)
                let albumMovie = AlbumMovie(id: uuid, album: album, movies: self.movies)
                self.albumMovies.append(albumMovie)
                AlbumManager.shared.addAlbum(album: album)
                AlbumMovieManager.shared.addAlbumMovie(albumMovie: albumMovie)
                self.watchListMovieTableView.reloadData()
            } else {
                let alert = UIAlertController(title: "", message: "Please enter name album", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleDismiss() {
        self.dataDelegate?.changeStatusButton()
    }
    
    // MARK: - Fetch Data from Realm DB
    private func fetchWatchListMovie() {
        albumMovies = AlbumMovieManager.shared.fetchAllAlbumMovie()
        watchListMovieTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension WatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEnabledDismissButton.enabled {
            guard let albumCell = tableView.cellForRow(at: indexPath) as? AlbumCell else { return }
            guard let movie = movie else { return }
            guard let selectedAlbumItem = albumMovies[indexPath.row].album else { return }
            let albumMovieSelected = AlbumMovieManager.shared.fetchAlbumMovieBy(primaryKey: albumMovies[indexPath.row].id)
            AlbumMovieManager.shared.updateAlbumMovie(albumMovie: albumMovieSelected, movie: movie)
            MovieManager.shared.update(movie: movie, by: nil, in: true)
            albumCell.setupDisplay(album: selectedAlbumItem, quantity: albumMovieSelected.movies.count)
        } else {
            let albumVC = AlbumViewController(nibName: "AlbumViewController", bundle: nil)
            albumVC.albumMovie = albumMovies[indexPath.row]
            self.navigationController?.pushViewController(albumVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = .disclosureIndicator
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - UITableViewDataSource
extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if albumMovies.count == 0 {
            self.watchListMovieTableView.setEmptyMessage("No album in watch list. Create one")
        } else {
            self.watchListMovieTableView.restore()
        }
        return albumMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.reuseableIdentifier, for: indexPath) as! AlbumCell
        guard let albumItem = albumMovies[indexPath.row].album else { return UITableViewCell() }
        cell.setupDisplay(album: albumItem, quantity: albumMovies[indexPath.row].movies.count)
        return cell
    }
}
