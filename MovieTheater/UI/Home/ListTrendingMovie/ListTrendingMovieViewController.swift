//
//  ListTrendingMovieViewController.swift
//  MovieTheater
//
//  Created by duytran on 10/7/21.
//

import UIKit


class ListTrendingMovieViewController: UIViewController {

    @IBOutlet weak var trendingMovieTableView: UITableView!
    var listTrendingMovie : [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTrendingMovieTableView()
    }
    
    // MARK:- Set Delegate & DataSource for trendingMovieTableView
    private func setupTrendingMovieTableView() {
        trendingMovieTableView.delegate = self
        trendingMovieTableView.dataSource = self
        let nib = UINib(nibName: "TrendingMovieCell", bundle: nil)
        trendingMovieTableView.register(nib, forCellReuseIdentifier: "TrendingMovieCell")
    }
}

// MARK:- UITableViewDelegate
extension ListTrendingMovieViewController: UITableViewDelegate {
    
}

// MARK:- UITableViewDataSource
extension ListTrendingMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTrendingMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingMovieCell", for: indexPath) as! TrendingMovieCell
        let movieItem = listTrendingMovie[indexPath.row]
        cell.setupDisplay(movie: movieItem)
        return cell
    }
}
