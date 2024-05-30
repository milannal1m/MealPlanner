//
//  CalenderView.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import SwiftUI
import UIKit
import FSCalendar
import EventKit



struct CalenderView: View {

    var body: some View {
        CalendarViewRepresentable()
    }
}

struct CalendarViewRepresentable: UIViewRepresentable {
    typealias UIViewType = FSCalendar
    
    func makeUIView(context: Context) -> FSCalendar {
        return FSCalendar()
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject,
        FSCalendarDelegate, FSCalendarDataSource {
        var parent: CalendarViewRepresentable
        
        init(parent: CalendarViewRepresentable) {
            self.parent = parent
        }
    }
}



#Preview {
    CalenderView()
}
