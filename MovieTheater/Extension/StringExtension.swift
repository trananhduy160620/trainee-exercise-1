//
//  String.swift
//  MovieTheater
//
//  Created by duytran on 10/6/21.
//

import Foundation

extension String {
    func toDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        let date: Date? = dateFormatterGet.date(from: self)
        return dateFormatterPrint.string(from: date!)
    }
}
