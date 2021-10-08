//
//  MovieDetailViewController.swift
//  MovieTheater
//
//  Created by duytran on 10/7/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var bigMovieImageView: UIImageView!
    @IBOutlet weak var thumbnailMovieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var userScoreStackView: UIStackView!
    @IBOutlet weak var containerRatingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var playTrailerButton: UIButton!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var categoryMovieLabel: UILabel!
    @IBOutlet weak var runtimeMovieLabel: UILabel!
    @IBOutlet weak var genresMovieLabel: UILabel!
    @IBOutlet weak var tagLineMovieLabel: UILabel!
    @IBOutlet weak var overviewMovieTextView: UITextView!
    
    var movie:Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDisplay()
    }
    // MARK:- Set up UI
    private func setupUI() {
        setupContainerRatingView()
        setupPlayTrailerButton()
        setupCategoryMovieLabel()
    }
    
    private func setupContainerRatingView() {
        // set up UI of containerRatingView
        containerRatingView.layer.cornerRadius = 32
        containerRatingView.layer.borderWidth = 1
        containerRatingView.layer.borderColor = UIColor.systemGreen.cgColor
        containerRatingView.layer.masksToBounds = true
    }
    
    private func setupSeparatorUserScoreStackView() {
//        if userScoreStackView.arrangedSubviews.count > 0 {
//            let separator = UIView()
//            separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
//            separator.backgroundColor = .black
//            userScoreStackView.addArrangedSubview(separator)
//            separator.heightAnchor.constraint(equalTo: userScoreStackView.heightAnchor, multiplier: 0.6).isActive = true
//        }
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
    
    private func setupDisplay() {
        if let m = movie {
            let urlString = "https://www.themoviedb.org/t/p/w220_and_h330_face" + m.posterPath
            guard let url = URL(string: urlString) else { return }
            bigMovieImageView.downloaded(from: url)
            thumbnailMovieImageView.downloaded(from: url)
            movieNameLabel.text = m.title
            ratingLabel.text = Double(m.rating * 10).clean + "%"
            runtimeMovieLabel.text = m.runtime.toTime()
            var temString = ""
            for genre in m.genres {
                temString = temString + genre.name + ", "
            }
            genresMovieLabel.text = temString
            tagLineMovieLabel.text = m.tagLine
            overviewMovieTextView.text = m.overview
        }
    }
    @IBAction func favoriteButtonClick(_ sender: UIButton) {
    }
    
    @IBAction func watchListButtonClick(_ sender: UIButton) {
    }
}
