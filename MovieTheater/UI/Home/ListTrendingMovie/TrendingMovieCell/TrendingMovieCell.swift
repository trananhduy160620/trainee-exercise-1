//
//  TrendingMovieCell.swift
//  MovieTheater
//
//  Created by duytran on 10/7/21.
//

import UIKit

class TrendingMovieCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateMovieLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.masksToBounds = true
    }
    public func setupDisplay(movie: Movie) {
        guard let movieImagePath = movie.posterPath else { return }
        guard let movieReleaseDate = movie.releaseDate else { return }
        guard let movieVoteCount = movie.voteCount else { return  }
        let urlString = "https://www.themoviedb.org/t/p/w220_and_h330_face" + movieImagePath
        guard let url = URL(string: urlString) else { return }
        movieImageView.downloaded(from: url)
        movieNameLabel.text = movie.title
        releaseDateMovieLabel.text = movieReleaseDate.toDate()
        voteCountLabel.text = "\(movieVoteCount) pts"
    }
}
