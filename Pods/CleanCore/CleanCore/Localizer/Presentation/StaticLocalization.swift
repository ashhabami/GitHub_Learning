//
//  StaticLocalization.swift
//  FMC
//
//  Created by Ondrej Fabian on 20/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public func localize(_ key: String) -> String {
    return LocalizerHolder.localizer.localize(key)
}

public func setStaticLocalizer(_ localizer: Localizer?) {
    LocalizerHolder.localizer = localizer!
}

public final class LocalizerHolder {
    static var localizer: Localizer!
}
