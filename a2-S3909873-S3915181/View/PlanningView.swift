//
//  PlanningView.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 23/9/2024.
//

import SwiftUI
import SwiftData

//(Raja Yogan 2024)
/// 'PlanningView' is an interface associated with the ``MenuView`` and presents the view selected
struct PlanningView: View {
    /// A binding variable that controls whether ``MenuView`` is presented or not
    @Binding var menuShown: Bool
    /// A binding variable that holds the currently selected view index 
    @Binding var viewIndex: String
    /// A parameter that represents the trip name
    var tripName: String
    /// A parameter that represents the trip starting date
    var tripStartDate: Date
    /// A parameter that represents the trip ending date
    var tripEndDate: Date
    /// A state variable which is a string that holds the description of the trip retrieved from UserDefaults
    @State var tripDescription: String = UserDefaults.standard.string(forKey: "DESCRIPTION_KEY") ?? "" //(Indently 2021)
    var body: some View {
        
        //(Raja Yogan 2024)
        // A template that presents the selected menu view
        VStack{
            HStack{
                Button(action: {
                    withAnimation(.spring()){
                        menuShown.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 25))
                        .foregroundStyle(Color.green)
                }
                Spacer()
                Text(tripName)
                    .font(.system(.title, design: .rounded))
                Spacer()

        }
            HStack{
                Text(CustomDateFormat.formatDate(tripStartDate))
                    .font(.system(size: 18))
                    .foregroundStyle(Color.blue)
                Image(systemName: "arrow.right")
                    .bold()
                    .padding(4)
                Text(CustomDateFormat.formatDate(tripEndDate))
                    .font(.system(size: 18))
                    .foregroundStyle(Color.blue)

            }
            Divider()
            Spacer()
            
            ZStack{
                PlannerView(tripname: tripName).opacity(viewIndex == "Planner" ? 1:0)
                ShareView(tripName: tripName).opacity(viewIndex == "Share" ? 1:0)
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))

        }
        .padding(20)
        
    }
}



/// A preview for ``PlanningView``
struct PlanningView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningView(menuShown: .constant(false), viewIndex: .constant("Planner"), tripName: "Sample", tripStartDate: Date(), tripEndDate: Date())
    }
}
