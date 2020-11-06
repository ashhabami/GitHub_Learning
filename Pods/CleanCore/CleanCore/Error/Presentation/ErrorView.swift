//
//  ErrorView.swift
//  FMC
//
//  Created by Ondrej Fabian on 25/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol ErrorView {
    func showError(_ error: DisplayableError, dismissTitle: String)
    func isErrorCurrentlyShown() -> Bool
}
