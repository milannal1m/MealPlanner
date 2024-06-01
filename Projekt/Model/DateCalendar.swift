//
//  DateCalendar.swift
//  Projekt
//
//  Created by Maximilian Kübler on 01.06.24.
//

import SwiftUI

class DateCalendar {
    struct DateValue: Identifiable {
        var id = UUID().uuidString
        var day: Int
        var date: Date
    }
}

