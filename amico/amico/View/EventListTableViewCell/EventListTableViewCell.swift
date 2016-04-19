//
//  EventListTableViewCell.swift
//  amico
//
//  Created by Yuriy B. on 4/14/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

final class EventListTableViewCell: UITableViewCell {
    static let nib = UINib(nibName: "EventListTableViewCell", bundle: nil)
    static let reuseIdentifier = "eventListTableViewCell"

    @IBOutlet private weak var collectionView: UICollectionView?

    var collectionViewOffset: CGFloat {
        set {
            collectionView?.contentOffset.x = newValue
        }

        get {
            return collectionView?.contentOffset.x ?? 0
        }
    }
}

extension EventListTableViewCell {
    //MARK: Cell Setup
    func setCollectionViewDataSourceDelegate<T: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: T, forRow row: Int) {
        guard let collectionView = collectionView else {
            return
        }

        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }
}
