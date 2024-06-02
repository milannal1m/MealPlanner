//
//  CalenderView.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import SwiftUI
import SwiftData

struct CalenderView: View {
    @State var currentMonth: Int = 0
    @State var currentDate: Date = Date()
    @Query var recipes: [Recipe]
    @Query var meals: [Meal]
    @Environment(\.modelContext) private var modelContext
    @State var showRecipePicker: Bool = false
    @State var mealsOnDate: [Meal] = []
    var body: some View {
        VStack{
            
            let weekDays: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            
            HStack(spacing: 15) {
                VStack {
                    Text(getYearMonthDate()[1])
                        .font(.caption)
                        .fontWeight(.bold)
                    
                    Text(getYearMonthDate()[0])
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Button {
                    showRecipePicker = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                }
                
                Button {
                    withAnimation{currentMonth -= 1}
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                Button {
                    withAnimation{currentMonth += 1}
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showRecipePicker){
                RecipePickerView(pickedDate: currentDate)
            }
            
            HStack(spacing: 10) {
                ForEach(weekDays, id: \.self){day in
                        Text(day)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(getMonthDate()){value in
                    CView(value: value)
                        .background(
                        Capsule()
                            .fill(.blue)
                            .padding(.horizontal, 8)
                            .opacity(sameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                    )
                        .onTapGesture {
                            currentDate = value.date
                            mealsOnDate = meals.filter{ meal in
                                sameDay(date1: meal.scheduledDate, date2: currentDate)
                            }
                        }
                }
            }
            
            VStack(spacing: 15){
                Text("Meals")
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if meals.first(where: { meal in
                    return sameDay(date1: meal.scheduledDate, date2: currentDate)
                }) != nil{
                    ForEach(mealsOnDate, id:\.self) { meal in
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("\(meal.recipe.name)")
                        }
                    }
                }
                else {
                    
                    Text("No meal found")
                    Spacer()
                }
            }
            .padding()
        }
        .onChange(of: currentMonth) {
            oldValue, newValue in
            
            currentDate  = getCurMonth()
        }
        
    }
    
    @ViewBuilder
    func CView(value: DateCalendar.DateValue) -> some View {
        VStack {
            if value.day != -1 {
                
                if let meal = meals.first(where: { meal in
                    return sameDay(date1: meal.scheduledDate, date2: value.date)
                }){
                    
                    Text("\(value.day)")
                        .font(.headline)
                        .foregroundStyle(sameDay(date1: meal.scheduledDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(sameDay(date1: meal.scheduledDate, date2: currentDate) ? .white : .blue)
                        .frame(width: 8, height: 8)
                }
                else {
                    Text("\(value.day)")
                        .font(.headline)
                        .foregroundStyle(sameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    func sameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func getCurMonth() -> Date {
        
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func getYearMonthDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getMonthDate()->[DateCalendar.DateValue]{
        let calendar = Calendar.current
        
        let currentMonth = getCurMonth()
                
        var days = currentMonth.getDates().compactMap { date -> DateCalendar.DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateCalendar.DateValue(day: day,date: date)
            
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateCalendar.DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

extension Date{
    func getDates() -> [Date] {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in 
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

#Preview {
    
    return CalenderView()
}

