//
//  Blocks.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 08/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

public typealias Block = () -> Void
public typealias StringBlock = ValueBlock<String>
public typealias IntBlock = ValueBlock<Int>
public typealias BoolBlock = ValueBlock<Bool>
public typealias ValueBlock<Value> = (_ value: Value) -> Void
