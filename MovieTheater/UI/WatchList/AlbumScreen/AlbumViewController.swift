//
//  AlbumViewController.swift
//  MovieTheater
//
//  Created by duytran on 12/13/21.
//

import UIKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var albumMovieTableView: UITableView!
    var albumMovie:AlbumMovie?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlbumMovieTableView()
    }
    
    private func setupAlbumMovieTableView() {
        albumMovieTableView.delegate = self
        albumMovieTableView.dataSource = self
        albumMovieTableView.register(FavoriteCell.nib, forCellReuseIdentifier: FavoriteCell.reuseableIdentifier)
    }
}

// MARK: - UITableViewDelegate
extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 236
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let album = albumMovie else { return }
        let movieItem = album.movies[indexPath.row]
        if editingStyle == .delete {
            AlbumMovieManager.shared.deleteMovieItem(in: album, movie: movieItem, at: indexPath.row)
            MovieManager.shared.update(movie: movieItem, by: nil, in: false)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let album = albumMovie else { return 0 }
        return album.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseableIdentifier, for: indexPath) as! FavoriteCell
        guard let album = albumMovie else { return UITableViewCell() }
        cell.setupDisplay(movie: album.movies[indexPath.row])
        return cell
    }
}
