//
//  MockUITableView.swift
//  DBCodingChallengeTests
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit
import XCTest

class MockTableView: UITableView {
    var reloadDataWasCalled = false
    var expectation: XCTestExpectation?
    
    override func reloadData() {
        reloadDataWasCalled = true
        expectation?.fulfill()
    }
}
