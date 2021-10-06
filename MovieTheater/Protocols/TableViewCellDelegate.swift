//
//  TableViewCellDelegate.swift
//  MovieTheater
//
//  Created by duytran on 10/6/21.
//

import UIKit

protocol TableViewCellDelegate: class {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}
