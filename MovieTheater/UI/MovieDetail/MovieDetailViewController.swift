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
    private var isFavoriteButtonClicked = false
    private var isBoorkmarkButtonClicked = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDisplay()
        self.adjustTextViewHeight()
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
        guard let m = movie else { return }
        isFavoriteButtonClicked = RealmManager.shared.fetchMovieBy(primaryKey: m.id).isFavor
        if isFavoriteButtonClicked {
            favoriteButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    private func setupBookmarkButton() {
        guard let m = movie else { return }
        isBoorkmarkButtonClicked = RealmManager.shared.fetchMovieBy(primaryKey: m.id).inWatchList
        if isBoorkmarkButtonClicked {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    private func setupDisplay() {
        if let m = movie {
            let urlString = "https://www.themoviedb.org/t/p/w220_and_h330_face" + m.posterPath
            guard let url = URL(string: urlString) else { return }
            largeMovieImageView.downloaded(from: url)
            smallMovieImageView.downloaded(from: url)
            movieNameLabel.text = m.title
            ratingLabel.text = Double(m.rating * 10).clean + "%"
            runtimeMovieLabel.text = m.runtime.toTime()
            var temString = ""
            for genre in m.genres {
                temString = temString + genre.name + ", "
            }
            genresMovieLabel.text = temString
            tagLineMovieLabel.text = m.tagLine != "" ? m.tagLine : "Tagline will be update"
            overviewMovieTextView.text = m.overview
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
        guard let m = movie else { return }
        RealmManager.shared.update(movie: m, by: isFavoriteButtonClicked)
    }
    
    @IBAction func watchListButtonClick(_ sender: UIButton) {
        isBoorkmarkButtonClicked = !isBoorkmarkButtonClicked
        if isBoorkmarkButtonClicked {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
        guard let m = movie else { return }
        RealmManager.shared.update(movie: m, in: isBoorkmarkButtonClicked)
    }
}

extension MovieDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.adjustTextViewHeight()
    }
}
