//
//  BaseTableViewController.swift
//  FMC
//
//  Created by Ondrej Fabian on 15/08/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import CleanCore
import UIKit

open class BaseTableViewController: UITableViewController, View, LoadingOverlay {

    open func startLoading() {
        if refreshControl == nil || refreshControl?.isRefreshing == false {
            startOverlayLoading()
        }
    }

    open func stopLoading() {
        if let refreshControl = self.refreshControl, refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        } else {
            stopOverlayLoading()
        }
    }
}
