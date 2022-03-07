//
//  ViewState.swift
//  swiftMVVM
//
//  Created by Vinicius Salmont on 06/03/22.
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case success
    case error(Error)
}
