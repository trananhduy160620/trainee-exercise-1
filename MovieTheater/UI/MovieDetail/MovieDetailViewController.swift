//
//  MovieDetailViewController.swift
//  MovieTheater
//
//  Created by duytran on 10/7/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var largeMovieImageView: UIImageView!
    @IBOutlet weak var smallMovieImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var containerRatingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var playTrailerButton: UIButton!
    @IBOutlet weak var categoryMovieLabel: UILabel!
    @IBOutlet weak var runtimeMovieLabel: UILabel!
    @IBOutlet weak var genresMovieLabel: UILabel!
    @IBOutlet weak var tagLineMovieLabel: UILabel!
    @IBOutlet weak var containerOverviewTextview: UIView!
    @IBOutlet weak var heightConstraintContainerView: NSLayoutConstraint!
    @IBOutlet weak var overviewMovieTextView: UITextView!
    
    var movie:Movie?
    var isFavoriteButtonClicked = false
    var isBoorkmarkButtonClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDisplay()
        self.adjustTextViewHeight()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK:- Set up UI
    private func setupUI() {
        overviewMovieTextView.delegate = self
        setupContainerRatingView()
        setupPlayTrailerButton()
        setupCategoryMovieLabel()
        setupFavoriteButton()
        setupBookmarkButton()
    }
    
    private func setupContainerRatingView() {
        containerRatingView.layer.cornerRadius = 32
        containerRatingView.layer.borderWidth = 1
        containerRatingView.layer.borderColor = UIColor.systemGreen.cgColor
        containerRatingView.layer.masksToBounds = true
    }
    
    private func setupPlayTrailerButton() {
        playTrailerButton.setTitle(" Play Trailer", for: .normal)
        playTrailerButton.setImage(UIImage(systemName: "play.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    private func setupCategoryMovieLabel() {
        categoryMovieLabel.layer.cornerRadius = 5
        categoryMovieLabel.layer.borderWidth = 1.5
        categoryMovieLabel.layer.borderColor = UIColor.white.cgColor
        categoryMovieLabel.layer.masksToBounds = true
    }
    
    private func setupFavoriteButton() {
        guard let movie = movie else { return }
        isFavoriteButtonClicked = MovieManager.shared.fetchMovieBy(primaryKey: movie.id).isFavor
        if isFavoriteButtonClicked {
            favoriteButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    private func setupBookmarkButton() {
        guard let movie = movie else { return }
        isBoorkmarkButtonClicked = MovieManager.shared.fetchMovieBy(primaryKey: movie.id).inWatchList
        if isBoorkmarkButtonClicked {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    private func setupDisplay() {
        if let movie = movie {
            let urlString = "https://www.themoviedb.org/t/p/w220_and_h330_face" + movie.posterPath
            guard let url = URL(string: urlString) else { return }
            largeMovieImageView.downloaded(from: url)
            smallMovieImageView.downloaded(from: url)
            movieNameLabel.text = movie.title
            ratingLabel.text = Double(movie.rating * 10).clean + "%"
            runtimeMovieLabel.text = movie.runtime.toTime()
            var temString = ""
            for genre in movie.genres {
                temString = temString + genre.name + ", "
            }
            genresMovieLabel.text = temString
            tagLineMovieLabel.text = movie.tagLine != "" ? movie.tagLine : "Tagline will be update in future"
            overviewMovieTextView.text = movie.overview
        }
    }
    
    private func adjustTextViewHeight() {
        let fixedWidth = overviewMovieTextView.frame.size.width
        let newSize = overviewMovieTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        self.heightConstraintContainerView.constant = newSize.height
        self.view.layoutIfNeeded()
    }
    
    @IBAction func favoriteButtonClick(_ sender: UIButton) {
        isFavoriteButtonClicked = !isFavoriteButtonClicked
        if isFavoriteButtonClicked {
            favoriteButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
        guard let movie = movie else { return }
        MovieManager.shared.update(movie: movie, by: isFavoriteButtonClicked, in: nil)
    }
    
    @IBAction func watchListButtonClick(_ sender: UIButton) {
        let watchListVC = WatchListViewController(nibName: "WatchListViewController", bundle: nil)
        let watchListNav = UINavigationController(rootViewController: watchListVC)
        guard let movie = movie else { return }
        watchListVC.isEnabledDismissButton = (enabled: true, color: .black)
        watchListVC.movie = movie
        watchListVC.dataDelegate = self
        self.present(watchListNav, animated: true, completion: nil)
    }
}

extension MovieDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.adjustTextViewHeight()
    }
}

extension MovieDetailViewController : DataDelgate {
    func changeStatusButton() {
        self.dismiss(animated: true) {
            self.setupBookmarkButton()
        }
    }
}
