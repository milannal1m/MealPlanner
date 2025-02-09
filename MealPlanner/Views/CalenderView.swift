//
//  CalenderView.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import SwiftUI
import SwiftData

struct CalenderView: View {
    @State var currentWeek: Int = 0
    @State var currentDate: Date = Date()
    @Query var recipes: [Recipe]
    @Query var meals: [Meal]
    @Environment(\.modelContext) private var modelContext
    @State var mealsOnDate: [Meal] = []
    @Environment(\.colorScheme) var colorScheme
    @State private var showRecipePickerView = false
    
    let weekDays: [String] = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter.shortWeekdaySymbols
    }()
    
    var body: some View {
        VStack{
            
            HStack(spacing: 0) {
                HStack {
                    Text(getYearMonthDate()[0])
                        .font(.system(size:30, weight: .heavy, design: .serif))
                    
                    Text(getYearMonthDate()[1])
                        .font(.system(size:30, weight: .heavy, design: .serif))
                }
                
                Spacer()
                
                
                Button {
                    withAnimation{currentWeek -= 1}
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size:25, weight: .heavy, design: .serif))
                        .foregroundColor(.primary)
                    
                }
                .padding(.horizontal,30)
                Button {
                    withAnimation{currentWeek += 1}
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size:25, weight: .heavy, design: .serif))
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            .padding(.top,10)
            .onAppear{
                mealsOnDate = meals.filter{ meal in
                    sameDay(date1: meal.scheduledDate, date2: currentDate)
                }
            }
            .onChange(of: showRecipePickerView){
                mealsOnDate = meals.filter{ meal in
                    sameDay(date1: meal.scheduledDate, date2: currentDate)
                }
            }
            
            HStack(spacing: 10) {
                ForEach(weekDays, id: \.self){day in
                    Text(day)
                        .font(.system(size:17, weight: .regular, design: .serif))
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(getCurrentWeek()){value in
                    CView(value: value)
                        .background(
                            Capsule()
                                .fill(
                                    sameDay(date1: value.date, date2: currentDate)
                                    ? (colorScheme == .dark ? .white : .black)
                                    : (colorScheme == .dark ? .black : .white)
                                )
                            
                                .padding(.horizontal, 8)
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
                
                MealsListView(meals: $mealsOnDate, showRecipePickerView: $showRecipePickerView, pickedDate: $currentDate)
                Spacer()

            }
            .padding()
        }
        .onChange(of: currentWeek) {
            oldValue, newValue in
            
            currentDate  = getPickedWeek()
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
                        .font(.system(size:20, weight: .regular, design: .serif))
                        .foregroundStyle(sameDay(date1: meal.scheduledDate, date2: currentDate) ? (colorScheme == .dark ? .black : .white)
                                         : (colorScheme == .dark ?  .white : .black))
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(sameDay(date1: meal.scheduledDate, date2: currentDate) ? (colorScheme == .dark ? .black : .white)
                              : (colorScheme == .dark ?  .white : .black))
                        .frame(width: 6, height: 6)
                }
                else {
                    Text("\(value.day)")
                        .font(.system(size:20, weight: .regular, design: .serif))
                        .foregroundStyle(sameDay(date1: value.date, date2: currentDate) ? (colorScheme == .dark ? .black : .white)
                                         : (colorScheme == .dark ?  .white : .black))
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 50, alignment: .top)
    }
    
    func sameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    
    func getYearMonthDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    
    func getPickedWeek() -> Date {
        
        let calendar = Calendar.current
        
        guard let currentWeek = calendar.date(byAdding: .weekOfYear, value: self.currentWeek, to: Date()) else {
            return Date()
        }
        
        return currentWeek
    }
    
    func getCurrentWeek() -> [DateCalendar.DateValue] {
        let calendar = Calendar.current
        
        let date = getPickedWeek()
        
        let weekday = calendar.component(.weekday, from: date)
        let daysToSubtract = (weekday == 1) ? 0 : (weekday)
        
        let startOfWeek = calendar.date(byAdding: .day, value: -daysToSubtract, to: date) ?? date
        
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) ?? date
        
        var weekDays: [DateCalendar.DateValue] = []
        var currentDay = startOfWeek
        
        while currentDay <= endOfWeek {
            let day = calendar.component(.day, from: currentDay)
            weekDays.append(DateCalendar.DateValue(day: day, date: currentDay))
            currentDay = calendar.date(byAdding: .day, value: 1, to: currentDay) ?? currentDay
        }
        
        return weekDays
    }
    
    func getCurrentWeekNumber(for date: Date) -> Int? {
        let calendar = Calendar.current
        let weekOfYear = calendar.component(.weekOfYear, from: date)
        return weekOfYear
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Ingredient.self, Recipe.self, configurations: config)
    
    let recipe = Recipe(name: "Spaghetti Bolognese")
    
    container.mainContext.insert(recipe)
    
    return CalenderView()
        .modelContainer(container)
}
