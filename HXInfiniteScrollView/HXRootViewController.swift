//
//  HXRootViewController.swift
//  HXInfiniteScrollView
//
//  Created by RockerHX on 2017/4/10.
//  Copyright © 2017年 RockerHX. All rights reserved.
//


import UIKit


class HXRootViewController: UITableViewController {

    fileprivate var items = [UIView]()

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

        items.append(contentsOf: [label0, label1, label2])
    }

    // MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is HXInfiniteScrollViewController {
            let controller = segue.destination as! HXInfiniteScrollViewController
            controller.items = items
        }
    }

    // MARK: - Event Methods -
    @IBAction func closeEvent(segue: UIStoryboardSegue) {}
}
