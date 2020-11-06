//
//  PushTokenNotifier.swift
//  FMC
//
//  Created by Ondrej Fabian on 22/02/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public typealias PushTokenUpdateBlock =  ValueBlock<PushToken>
public typealias PushTokenFailBlock = ValueBlock<PushTokenError>

public protocol PushTokenNotifier {
    func loadToken(tokenUpdate updated: @escaping PushTokenUpdateBlock, updateFailed: @escaping PushTokenFailBlock)
}
