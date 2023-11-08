//
//  AppDataModel+State.swift
//  3DCaptureHack
//
//  Created by Student08 on 07/11/2023.
//


import Foundation

extension AppDataModel {
    enum ModelState: String, CustomStringConvertible {
        var description: String { rawValue }

        case notSet
        case ready
        case capturing
        case prepareToReconstruct
        case reconstructing
        case viewing
        case completed
        case restart
        case failed
    }
}
