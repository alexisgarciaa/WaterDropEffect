 //
//  Home.swift
//  WaterDropEffect
//
//  Created by Alexis on 16/7/22.
//

import SwiftUI

struct Home: View {
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    var body: some View {
        ZStack (alignment:.topTrailing){
            VStack{
                //MARK: here is your picture profile
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100 , height: 100 )
                    .clipShape(Circle())
                    .padding()
                    .background(.white, in: Circle() )
                
                //MARK: here is your nameUser
                Text("July")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.bottom, 30  )
                
                //MARK: waive form
                GeometryReader{ proxy in
                    let size = proxy.size
                    
                    //MARK: WATER IMAGE
                    
                    ZStack{
                        Image(systemName: "drop.fill")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                        //streching in x axis
                            .scaleEffect(x:1.1, y:1 )
                            .offset(y: -1 )
                        
                        //MARK: waive form shape
                        WaterWave(progressWave: progress , waiveHeight: 0.04 , offset: startAnimation)
                            .fill(Color.blue)
                        //WaterDrops
                            .overlay(
                                ZStack{
                                    Circle()
                                        .fill(.white).opacity(0.1)
                                        .frame(width: 15, height: 15 )
                                        .offset(x: -20 )
                                    Circle()
                                        .fill(.white).opacity(0.1)
                                        .frame(width: 15, height: 15 )
                                        .offset(x: 40, y:30  )
                                    Circle()
                                        .fill(.white).opacity(0.1)
                                        .frame(width: 25, height: 25 )
                                        .offset(x: -30, y: 80  )
                                    Circle()
                                        .fill(.white).opacity(0.1)
                                        .frame(width: 15, height: 15 )
                                        .offset(x: 50 , y:70 )
                                    Circle()
                                        .fill(.white).opacity(0.1)
                                        .frame(width: 10, height: 10 )
                                        .offset(x: -40, y: 50  )
                                }
                            )
                            //Masking into drop shape
                            .mask(
                                Image(systemName: "drop.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(20 )
                            )
                            .overlay(alignment: .bottom) {
                                Button {
                                    progress += 0.01
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.system(size: 40, weight: .black))
                                        .foregroundColor(.blue)
                                        .shadow(radius: 2)
                                        .padding(25)
                                        .background(.white, in: Circle())
                                }
                                .offset(y: 40)

                            }
                    }
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .onAppear{
                        //Looping Animation
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){
                            startAnimation = size.width
                        }
                    }
                    
                }
                .frame( height: 350)
                
                Slider(value: $progress)
                    .offset(y:90)
                    .padding()
                    .background(.white, in: RoundedRectangle(cornerRadius: 10).offset(y:90))
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .top  )
        .background(Color("Background"))
            
            Text("\(Int(progress * 10))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding()
                .offset(y: -10)
                .background(.white, in: Circle().offset(y:-10))
                .padding()
            Text("Vasos")
                .font(.caption)
                .fontWeight(.bold)
                .offset(x: -25, y: -5)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct WaterWave: Shape {
    var progressWave : CGFloat
    var waiveHeight: CGFloat
    //Initial animation start
    var offset : CGFloat
    
    //Enabling animation
    var animatableData: CGFloat {
        get{offset}
        set{offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: .zero )
            
            //MARK: drawing Waves using Sine
            let progressHeight: CGFloat = (1 - progressWave) * rect.height
            let height = waiveHeight  * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2) {
                let x : CGFloat = value
                let sine: CGFloat = sin(Angle(degrees:value + offset).radians  )
                let y : CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            //  Botton portion
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
    
    
}
