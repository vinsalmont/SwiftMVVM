//
//  RequestDelegate.swift
//  swiftMVVM
//
//  Created by Vinicius Salmont on 06/03/22.
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import Foundation

enum RequestStatus {
    case success
    case failed(Error)
}

protocol RequestDelegate: AnyObject {
    func didFinish(with status: RequestStatus)
}
