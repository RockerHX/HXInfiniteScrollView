//
//  HXInfiniteScrollViewController.swift
//  HXInfiniteScrollView
//
//  Created by RockerHX on 2017/3/21.
//  Copyright © 2017年 RockerHX. All rights reserved.
//


import UIKit


class HXInfiniteScrollViewController: UICollectionViewController {
    
    // MARK: - Private Property -
    private var originalItems = [UIView]()
    private var recombineItems = [UIView]()
    
    public var items: [UIView] {
        get { return originalItems }
        set {
            originalItems = newValue
            recombineItems = newValue
            
            setupItems()
        }
    }
    
    // MARK: - View Controller Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label0 = UILabel()
        label0.text = "0"
        label0.textAlignment = .center
        label0.backgroundColor = UIColor.red
        
        let label1 = UILabel()
        label1.text = "1"
        label1.textAlignment = .center
        label1.backgroundColor = UIColor.green
        
        let label2 = UILabel()
        label2.text = "2"
        label2.textAlignment = .center
        label2.backgroundColor = UIColor.blue
        
        items = [label0, label1, label2]
    }
    
    // MARK: - Private Methods -
    private func setupItems() {
        
        if let firstItem = originalItems.first, let lastItem = originalItems.last {
            recombineItems.insert(lastItem, at: 0)
            recombineItems.append(firstItem)
        }
        
        collectionView?.reloadData()
        collectionView?.performBatchUpdates(nil, completion: { [weak self] (completion) in
            if completion {
                self?.scrollToFirstItem()
            }
        })
    }
    
    private func scrollToFirstItem() {
        let indexPath = IndexPath.init(item: 1, section: 0)
        scrollToItem(at: indexPath)
    }
    
    private func scrollToLastItem() {
        let indexPath = IndexPath.init(item: (recombineItems.count - 2), section: 0)
        scrollToItem(at: indexPath)
    }
    
    private func scrollToItem(at indexPath: IndexPath) {
        collectionView?.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    // MARK: - Collection View Data Source Methods -
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recombineItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HXInfiniteScrollViewCell.self), for: indexPath) as! HXInfiniteScrollViewCell
        cell.append(view: recombineItems[indexPath.row])
        return cell
    }
    
    // MARK: - Collection View Delegate Methods -
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Index:\(originalItems.index(of: recombineItems[indexPath.row]))")
    }
    
    // MARK: - Scroll View Delegate Methods -
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let contentOffsetWhenFullyScrolledRight = (collectionView?.frame.width)! * CGFloat(recombineItems.count - 1)
        if contentOffsetX == contentOffsetWhenFullyScrolledRight {
            let indexPath = IndexPath.init(item: 1, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .left, animated: false)
        } else if contentOffsetX == 0 {
            scrollToLastItem()
        }
    }
}


extension HXInfiniteScrollViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = UIApplication.shared.windows.first!.frame
        return CGSize(width: frame.width, height: frame.height)
    }
}

