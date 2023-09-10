//
//  MainView.swift
//  WeatherApp
//
//  Created by Thore Brehmer on 07.09.23.
//

import SwiftUI

struct MainView: View {
    
    @State var isNight: Bool = false
    
    var body: some View {
        ZStack {
            WeatherBackground(isNight: isNight)
            
            VStack{
                
                WeatherTitle(title: "Berlin, Spandau")
                
                Spacer()
                
                MainWeather(weather: _getRandomWeather(isNight: isNight, weekday: ""))
                
                WeekdaysWeather(weathers: [
                    _getRandomWeather(isNight: isNight, weekday: "Mon"),
                    _getRandomWeather(isNight: isNight, weekday: "Tue"),
                    _getRandomWeather(isNight: isNight, weekday: "Wen"),
                    _getRandomWeather(isNight: isNight, weekday: "Thu"),
                    _getRandomWeather(isNight: isNight, weekday: "Fri")])
                
                Spacer()
                
                ToggleButton(isNight: $isNight)

                
                
            }
        }
    }
    
    private func _getRandomWeather(isNight: Bool, weekday:String) -> Weather{
        return Weather(isNight: isNight, temperature: Int.random(in: -5..<35), weekday: weekday, type: [WeatherType.Clear, WeatherType.Cloud, WeatherType.Hail, WeatherType.Rain, WeatherType.Snow, WeatherType.Thunder, WeatherType.Wind].randomElement()!)
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct WeatherBackground: View {
    //paras
    let isNight:Bool
    
    //vars
    var startColor: Color
    var endColor: Color
    
    //constructor
    init(isNight: Bool) {
        self.isNight = isNight
        switch(isNight){
        case true:
            self.startColor = .gray
            self.endColor = .white
        case false:
            self.startColor = .blue
            self.endColor = Color("WeatherLightBlue")
        }
        
    }
    
    var body: some View {
        LinearGradient(
            colors: [startColor,endColor],
            startPoint: .top,
            endPoint: .bottom)
        .ignoresSafeArea()
    }
}

struct WeatherTitle: View {
    let title:String
    
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .foregroundColor(.white)
            .fontWeight(.semibold)
    }
}

struct MainWeather: View {
    var weather: Weather
    
    var body: some View {
        VStack(spacing:8){
            WeatherIcon(type: weather.type, isNight: weather.isNight, size: 150)
            
            Text("\(weather.temperature)")
                .font(.system(size: 60))
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }
        .padding(.bottom, 60)
    }
}

struct Weather{
    let isNight: Bool
    let temperature: Int
    let weekday: String
    let type: WeatherType
}

enum WeatherType{
    case Cloud
    case Rain
    case Thunder
    case Hail
    case Snow
    case Wind
    case Clear
}

struct WeatherIcon: View{
    let type: WeatherType
    let isNight: Bool
    let systemIcon: String
    let size: CGFloat
    
    init(type: WeatherType, isNight: Bool, size: CGFloat) {
        self.type = type
        self.isNight = isNight
        self.size = size
        switch type {
            case WeatherType.Cloud:
                self.systemIcon = isNight ? "cloud.moon.fill" : "cloud.sun.fill"
            case WeatherType.Rain:
                self.systemIcon = isNight ? "cloud.moon.rain.fill" : "cloud.sun.rain.fill"
            case WeatherType.Thunder:
                self.systemIcon = isNight ? "cloud.moon.bolt.fill" : "cloud.sun.bolt.fill"
            case WeatherType.Hail:
                self.systemIcon = "cloud.hail.fill"
            case WeatherType.Snow:
                self.systemIcon = "cloud.snow.fill"
            case WeatherType.Wind:
                self.systemIcon = "wind"
            case WeatherType.Clear:
                self.systemIcon = isNight ? "moon.fill" : "sun.max.fill"
        }
        
    }
    
    var body: some View{
        Image(systemName: systemIcon)
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

struct NextWeekDay: View {
    var weather: Weather
    
    var body: some View {
        VStack(spacing:8){
            Text(weather.weekday)
                .font(.title3)
                .foregroundColor(.white)
            WeatherIcon(type: weather.type, isNight: weather.isNight, size: 50)
            Text("\(weather.temperature)")
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

struct WeekdaysWeather: View {
    //paras
    var weathers: [Weather]
    
    ///constructor
    init(weathers: [Weather]) {
        self.weathers = weathers
        assert(weathers.count == 5)
    }
    
    //vars
    let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        ///grid instead of h-stack so width is flexible
        LazyVGrid(columns: columns, content: {
            ForEach(0..<5) { i in
                NextWeekDay(weather: weathers[i])
            }
        }).padding(.horizontal)
    }
}

struct ToggleButton: View {
    @Binding var isNight:Bool
    
    var body: some View {
        Button {
            isNight.toggle()
        } label: {
            Text("Toggle Datime")
                .foregroundColor(.white)
                .frame(width: 150, height: 50)
                .background(isNight ? .gray : .blue)
                .cornerRadius(15)
                .shadow(radius: 10)
            
        }
    }
}




//For Unit testing only
enum Vorzeichen {
    case positiv, negative
}
enum CustomError: Error {
    case isZero
}
struct ForUnitTestOnly {
    func abs(num: Int, sign: Vorzeichen) throws -> Int? {
        guard num != 0 else {
            throw CustomError.isZero
        }
        guard num != -1 else {
            return nil
        }
        switch sign {
        case Vorzeichen.positiv:
            return num < 0 ? -1 * num : num
        case Vorzeichen.negative:
            return num < 0 ? num : -1 * num
        }
    }
}
