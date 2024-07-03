import SwiftUI
import Foundation
import MapKit

struct EventModal: View {
    @Binding var isEventPresented: Bool
    @EnvironmentObject var eventStore: EventStore
    @EnvironmentObject var vm: MapEnvironment
    @Binding var isJoinedEvent: Bool
    
    @Binding var event: Event
    
    @State var timeRemaining = 10
    
    var body: some View {
        let pos = MapCameraPosition.region( MKCoordinateRegion( center: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.01) ))
        
        
        VStack (alignment: .leading){
            ZStack {
                event.category.color.opacity(0.2)
                    .frame(height: 170)
                    .ignoresSafeArea()
                TimerView(setDate: event.date)
                    .padding(.bottom, -20)
            }
            .padding(.bottom, 5)
            
            Text(event.name)
                .bold()
                .font(.title)
                .padding(.leading, 20)
                .padding(.bottom, 5)
            HStack {
                Image(systemName: "calendar")
                    .padding(.leading, 20)
                    .font(.system(size: 20))
                Text(event.date, style: .date)
            }
            .padding(.bottom, 5)
            
            HStack {
                Image(systemName: "clock")
                    .padding(.leading, 20)
                    .font(.system(size: 20))
                Text(event.date, style: .time)
            }
            .padding(.bottom, 5)
            
            HStack {
                Image(systemName: "mappin")
                    .padding(.leading, 20)
                    .font(.system(size: 20))
                Text(event.location)
            }
            .padding(.bottom, 10)
            ZStack{
                Color.blue
                Text("map")
                Map(initialPosition: pos) {
                    Annotation(event.name, coordinate: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)){
                        ZStack {
                            VStack(spacing:0){
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.red)
                                    .background(Color.white)
                                    .cornerRadius(500)
                                Image(systemName: "arrowtriangle.down.fill")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .offset(x: 0, y: -5)
                            }
                        }
                    }
                }
            }
            .frame(height: 300)
            .padding(.bottom, 30)
            HStack {
                Button(action: {
                    isJoinedEvent ? vm.removeUserEvent(eventItem: event) : vm.addToUserEvents(event: event)
                    isEventPresented.toggle()
                }, label: {
                    Text(isJoinedEvent ? "Leave Event" : "Join Event")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(isJoinedEvent ? Color.red : Color.green)
                        .cornerRadius(8)
                        .padding(.leading)
                })
                
                Button(action: {
                    isEventPresented.toggle()
                }, label: {
                    Text("Close")
                        .foregroundColor(.red)
                        .fontWeight(.semibold)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 1)
                        )
                        .padding(.trailing)
                })
            }
            
            Color.clear
        }
        
    }
}

#Preview {
    EventModal(isEventPresented: Binding.constant(true), isJoinedEvent: Binding.constant(true), event: Binding.constant(Event(id: 3, name: "Test Event", date: Date.now, location: "Tysons", category: .anything, latitude: 38, longitude:-77, userIds: ["john"])))
}


struct TimerView: View {
    
    @State var nowDate: Date = Date()
    let setDate: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        TimerFunction(from: setDate)
//        Text(TimerFunction(from: setDate))
    }
    
    func TimerFunction(from date: Date) -> AnyView {
        let remainingTime = setDate.timeIntervalSince(nowDate)
        
        let calendar = Calendar(identifier: .gregorian)
        let timeValue = calendar
            .dateComponents([.day, .hour, .minute, .second], from: nowDate, to: setDate)
        
        if remainingTime > 0 {
            return AnyView(HStack {
                VStack (alignment: .center){
                    Text(String(format: "%02d", timeValue.day!))
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                        .onAppear(perform: {
                            self.timer
                        })
                    Text("DAYS")
                        .font(.system(size: 12))
                        .frame(alignment: .center)

                }
                
                VStack {
                    Text(" : ")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                    Text(" ")
                }
                
                VStack (alignment: .center){
                    Text(String(format: "%02d", timeValue.hour!))
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                        .onAppear(perform: {
                            self.timer
                        })
                    Text("HOURS")
                        .font(.system(size: 12))
                        .frame(alignment: .center)


                }
                
                VStack {
                    Text(" : ")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                    Text(" ")
                }
                
                VStack (alignment: .center){
                    Text(String(format: "%02d", timeValue.minute!))
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                        .onAppear(perform: {
                            self.timer
                        })
                    Text("MINUTES")
                        .font(.system(size: 12))
                        .frame(alignment: .center)

                }
                
                VStack {
                    Text(" : ")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                    Text(" ")
                }
                
                VStack (alignment: .center) {
                    Text(String(format: "%02d", timeValue.second!))
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                        .onAppear(perform: {
                            self.timer
                        })
                    Text("SECONDS")
                        .font(.system(size: 12))
                        .frame(alignment: .center)
                }
            })
        } else {
            return AnyView(HStack {
                VStack (alignment: .center){
                    Text("00")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                    Text("DAYS")
                        .font(.system(size: 12))
                        .frame(alignment: .center)
                }
                
                VStack {
                    Text(" : ")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                    Text(" ")
                }
                
                VStack (alignment: .center) {
                    Text("00")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                    Text("HOURS")
                        .font(.system(size: 12))
                        .frame(alignment: .center)
                }
                
                VStack {
                    Text(" : ")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                    Text(" ")
                }
                
                VStack (alignment: .center) {
                    Text("00")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                    Text("MINUTES")
                        .font(.system(size: 12))
                        .frame(alignment: .center)
                }
                
                VStack {
                    Text(" : ")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                    Text(" ")
                }
                
                VStack (alignment: .center) {
                    Text("00")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, -10)
                    Text("SECONDS")
                        .font(.system(size: 12))
                        .frame(alignment: .center)
                }
            })
        }
    }
}
