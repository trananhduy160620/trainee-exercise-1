//
//  IntExtension.swift
//  MovieTheater
//
//  Created by duytran on 10/8/21.
//

import Foundation

extension Int {
    func toTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated

        let formattedString = formatter.string(from: TimeInterval(self))!
        return formattedString
    }
}
