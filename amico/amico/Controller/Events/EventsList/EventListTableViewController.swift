//
//  EventListTableViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/14/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

final class EventListTableViewController: UITableViewController {
    static let storyboardId = "eventListTableViewController"

    static var token = dispatch_once_t()

    var datasource:[[UIColor]] = [
        [UIColor.redColor(), UIColor.redColor(), UIColor.redColor(), UIColor.redColor()],
        [UIColor.redColor(),UIColor.redColor()],
        [UIColor.redColor(),UIColor.redColor(),UIColor.redColor(),UIColor.redColor(),UIColor.redColor()],
        [UIColor.redColor(),UIColor.redColor(),UIColor.redColor()],
        [UIColor.redColor(),UIColor.redColor(),UIColor.redColor()]
    ]

    var storedOffsets: [Int : CGFloat] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(EventListTableViewCell.nib, forCellReuseIdentifier: EventListTableViewCell.reuseIdentifier)
    }
}

extension EventListTableViewController {
    //MARK:- Action Buttons
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension EventListTableViewController {
    //MARK:- UITableViewDataSource, UITableViewDelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(EventListTableViewCell.reuseIdentifier) as? EventListTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? EventListTableViewCell else {
            return
        }

        cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }

    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? EventListTableViewCell   else {
            return
        }

        storedOffsets[indexPath.row] = cell.collectionViewOffset
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
}

extension EventListTableViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    //MARK:- UICollectionViewDataSource, UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource[collectionView.tag].count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        collectionView.registerNib(CollectionViewCell.nib, forCellWithReuseIdentifier: "Cell")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = datasource[collectionView.tag][indexPath.item]

        return cell
    }
}