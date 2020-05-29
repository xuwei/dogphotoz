//
//  CellViewModelProtocol.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

/**
 To keep tableviewcell viewModels consistent, so table can use this interface to register cells
 */
protocol CellViewModelProtocol {
    static func identifier()-> String
}
