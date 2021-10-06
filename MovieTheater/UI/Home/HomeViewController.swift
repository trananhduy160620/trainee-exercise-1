//
//  HomeViewController.swift
//  MovieTheater
//
//  Created by duytran on 10/5/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var movieTableView: UITableView!
    
    var movies:[Movie] = []
    var movie:Movie?
    var idArray = [550988, 56820, 703771, 681887, 580489, 637543, 589754, 725273, 839436, 335983, 566525, 436969, 451048]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .myColor
        
        setupLeftBarButton()
        setupTitleView()
        setupRightBarButtons()
       
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        movieTableView.register(HeaderTableView.self, forHeaderFooterViewReuseIdentifier: "HeaderTableView")
        
        createMoviesData()
    }
    
    // MARK:- setupLeftBarButton
    private func setupLeftBarButton() {
        let leftImage = UIImage(systemName: "line.horizontal.3")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let moreBarButton = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = moreBarButton
    }
    
    private func setupRightBarButtons() {
        let searchImage = UIImage(systemName: "magnifyingglass")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: nil)
        let userImage = UIImage(systemName: "person.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let userBarButton = UIBarButtonItem(image: userImage, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [searchBarButton, userBarButton]
    }
    
    private func setupTitleView() {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "img_tmdb")
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    // action for show all button click
    @objc func showAllButtonClick() {
        print(123)
    }
    
    // Initialized Movie Data
    private func createMoviesData() {
        MovieServiceManager.shared.fetchMovieByIDs(IDs: idArray) { (result) in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.movieTableView.reloadData()
                print(self.movies[3].releaseDate.toDate())
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK:- UITableViewDelegate
extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderTableView(reuseIdentifier: "HeaderTableView")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }
}

// MARK:- UITableViewDataSource
extension HomeViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.delegate = self
        cell.movieCollectionView.reloadData()
        return cell
    }
}

// MARK:- TableViewCellDelegate
extension HomeViewController : TableViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        let movieItem = movies[indexPath.row]
        cell.setupDisplay(movie: movieItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell cell cell")
    }
    
    
}


