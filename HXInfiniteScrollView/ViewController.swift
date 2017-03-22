//
//  ViewController.swift
//  HXInfiniteScrollView
//
//  Created by RockerHX on 2017/3/21.
//  Copyright © 2017年 RockerHX. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    // MARK: - Private Property -
    private var items = [Any]()
    
    // MARK: - View Controller Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataForCollectionView()
    }
    
    // MARK: - Private Methods -
    private func setupDataForCollectionView() {
        let originalItems = ["1", "2", "3"]
        if let firstItem = originalItems.first, let lastItem = originalItems.last {
            var workItems = originalItems
            workItems.insert(lastItem, at: 0)
            workItems.append(firstItem)
            items = workItems
        }
        print(items)
        
        collectionView?.reloadData()
    }
    
    // MARK: - Collection View Data Source Methods -
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HXCollectionViewCell.self), for: indexPath) as! HXCollectionViewCell
        cell.indexLabel.text = items[indexPath.row] as? String
        return cell
    }
    
    // MARK: - Collection View Delegate Methods -
    
    // MARK: - Scroll View Delegate Methods -
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let contentOffsetWhenFullyScrolledRight = (collectionView?.frame.width)! * CGFloat(items.count - 1)
        if contentOffsetX == contentOffsetWhenFullyScrolledRight {
            let indexPath = IndexPath.init(item: 1, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .left, animated: false)
        } else if contentOffsetX == 0 {
            let indexPath = IndexPath.init(item: (items.count - 2), section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .left, animated: false)
        }
    }
}

