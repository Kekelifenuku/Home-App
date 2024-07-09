//
//  HomeView.swift
//  Smart device App
//
//  Created by Fenuku kekeli on 7/9/24.
//

import SwiftUI

struct HomeView: View {
    @State private var isLivingRoomOn = true
    @State private var isBedroomOn = false
    @State private var isBathroomOn = false
    @State private var rooms: [Room] = [
        Room(name: "Living Room", deviceCount: 7, isOn: true, color: .red),
        Room(name: "Bedroom", deviceCount: 5, isOn: false, color: .blue),
        Room(name: "Bathroom", deviceCount: 4, isOn: false, color: .yellow)
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Hello, David")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Image(systemName: "bell")
                    .font(.title)
            }
            .padding()

            Text("Welcome to your home")
                .font(.title3)
                .padding(.trailing, 140)
                .padding([.leading, .bottom])

            VStack(alignment: .leading) {
                HStack {
                    Text("Cloudy")
                    Spacer()
                    Text("7 July 2024")
                }
                HStack {
                    Text("27°")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Image(systemName: "cloud.fill")
                        .foregroundColor(.blue)
                        .font(.largeTitle)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.1)))
            .padding()

            HStack {
                Text("Your Rooms")
                    .font(.headline)
                    .padding([.leading, .top])
                Spacer()
                Button(action: {
                    withAnimation {
                        addRoom()
                    }
                }) {
                    Text("+ Add")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 100).fill(Color.blue.opacity(0.1)))
                        .foregroundColor(.green)
                        .cornerRadius(20)
                }
                .padding([.top, .trailing])
            }

            ForEach($rooms) { $room in
                RoomView(room: $room)
                    .transition(.slide)
                    .animation(.easeInOut, value: room.isOn)
            }

            Spacer()
        }
        .padding()
    }
    
    private func addRoom() {
        rooms.append(Room(name: "New Room", deviceCount: 0, isOn: false, color: .green))
    }
}

struct Room: Identifiable {
    let id = UUID()
    var name: String
    var deviceCount: Int
    var isOn: Bool
    var color: Color
}

struct RoomView: View {
    @Binding var room: Room

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(room.color)
                    .frame(width: 70, height: 70)
                Image(systemName: roomIcon(for: room.name))
                    .font(.title)
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                Text(room.name)
                    .font(.title2)
                Text("\(room.deviceCount) Devices")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text("•")
                .foregroundColor(room.color)
            Toggle(isOn: $room.isOn) {
                Text("")
            }
            .labelsHidden()
            .onChange(of: room.isOn) { newValue in
                withAnimation(.easeInOut) {
                    room.isOn = newValue
                }
            }
        }
        .padding()
        .frame(height: 100) // Increase the height of the card
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(room.isOn ? room.color.opacity(0.3) : Color.gray.opacity(0.1))
                .animation(.easeInOut, value: room.isOn)
        )
        .padding([.leading, .trailing])
    }

    private func roomIcon(for room: String) -> String {
        switch room {
        case "Living Room":
            return "sofa.fill"
        case "Bedroom":
            return "bed.double.fill"
        case "Bathroom":
            return "shower.fill"
        default:
            return "house.fill"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
