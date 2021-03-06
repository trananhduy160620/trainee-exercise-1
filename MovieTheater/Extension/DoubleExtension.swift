//
//  FloatExtension.swift
//  MovieTheater
//
//  Created by duytran on 10/6/21.
//

import Foundation
extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    var toTime : String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated

        let formattedString = formatter.string(from: TimeInterval(self))!
        return formattedString
    }
}
