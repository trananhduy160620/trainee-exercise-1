//
//  TableViewCell.swift
//  MovieTheater
//
//  Created by duytran on 10/6/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    weak var delegate : TableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        let nib = UINib(nibName: "MovieViewCell", bundle: nil)
        movieCollectionView.register(nib, forCellWithReuseIdentifier: "MovieViewCell")
    }
    func reloadDataInsideCollectionView() {
        movieCollectionView.reloadData()
    }
    func setTagForCollectionView(_ tag:Int) {
        movieCollectionView.tag = tag
    }
}

// MARK:- UICollectionViewDataSource
extension TableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItemsInSection = delegate?.collectionView(collectionView, numberOfItemsInSection: section) else {
            return 0
        }
        return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = delegate?.collectionView(collectionView, cellForItemAt: indexPath) else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK:- UICollectionViewDelegate
extension TableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}
