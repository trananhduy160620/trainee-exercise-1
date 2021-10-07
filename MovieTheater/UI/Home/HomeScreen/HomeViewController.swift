//
//  HomeViewController.swift
//  MovieTheater
//
//  Created by duytran on 10/5/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    private var popularMovies:[Movie] = []
    private var trendingMovies:[Movie] = []
    private var idPopularMovieArray = [550988, 56820, 703771, 681887, 580489, 637543, 589754,
                                       725273, 839436, 335983, 566525, 436969, 451048]
    private var idTrendingMovieArray = [370172, 567748, 524369, 639721, 857702, 631843, 619778, 451048,
                                        497698, 385128, 767504, 438631, 879540, 547565, 567565, 5675]
    private var movieCategory: MovieCategory = .None
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .myColor
        setupLeftBarButton()
        setupTitleView()
        setupRightBarButtons()
        setupMovieTableView()
        createPopularMoviesData()
        createTrendingMoviesData()
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
    
    // MARK:- Setup MovieTabelView
    private func setupMovieTableView() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        movieTableView.register(HeaderTableView.self, forHeaderFooterViewReuseIdentifier: "HeaderTableView")
    }
    
    // MARK: - Initialized Movie Data
    private func createPopularMoviesData() {
        MovieServiceManager.shared.fetchMovieByIDs(IDs: idPopularMovieArray) { (result) in
            switch result {
            case .success(let movies):
                self.popularMovies = movies
                self.movieTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func createTrendingMoviesData() {
        MovieServiceManager.shared.fetchMovieByIDs(IDs: idTrendingMovieArray) { (result) in
            switch result {
            case .success(let movies):
                self.trendingMovies = movies
                self.movieTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK:- UITableViewDelegate
extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderTableView(reuseIdentifier: "HeaderTableView")
        headerView.headerDelegate = self
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
        switch indexPath.section {
        case 0:
            movieCategory = .PopularMovie
        case 1:
            movieCategory = .TrendingMovie
        default:
            break
        }
        cell.delegate = self
        cell.reloadDataInsideCollectionView()
        cell.setTagForCollectionView(indexPath.section)
        return cell
    }
}

// MARK:- TableViewCellDelegate
extension HomeViewController : TableViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch movieCategory {
        case .PopularMovie:
            return popularMovies.count
        case .TrendingMovie :
            return trendingMovies.count / 2 // chỉ hiện thị 1 nửa danh sách các bộ phim trending
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        switch collectionView.tag {
        case 0:
            let movieItem = popularMovies[indexPath.item]
            cell.setupDisplay(movie: movieItem)
        case 1:
            let movieItem = trendingMovies[indexPath.item]
            cell.setupDisplay(movie: movieItem)
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell cell cell")
    }
}

// MARK:- HeaderTableViewDelegate
extension HomeViewController : HeaderTableViewDelegate {
    func handleShowAllButtonClick() {
        let listTrendingMovieVC = ListTrendingMovieViewController(nibName: "ListTrendingMovieViewController", bundle: nil)
        listTrendingMovieVC.listTrendingMovie = trendingMovies
        self.navigationController?.pushViewController(listTrendingMovieVC, animated: true)
    }
}


