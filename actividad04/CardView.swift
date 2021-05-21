
import SwiftUI

//Vista de la tarjeta
struct CardView: View{
    
    @EnvironmentObject var userInfo: UserInfo //se pueden utilizar los datos de userInfo(campos formulario)
    
    @State var expanded = true
    @State var color = "Color"
    @State var colors : [String] //array de datos declarado en el Navigator 
    
    var body: some View {
        
        //Se engloba todo dentro de un scrollView para correcto funcionamiento en diferentes tamaños y orientaciones
        ScrollView(.vertical){
            
            VStack{
                ZStack{
                    //Imagen del header
                    Image.init("trabajo")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .padding(.top, 20)
                    
                    //Titulo con el nombre de la app
                    Text("CARDMAKER")
                        .font(.custom("AmericanTypewriter-Light", fixedSize: 40))
                        .bold()
                        .foregroundColor(.orange)
                        .background(Color.init("ColorForm"))
                        .padding()
                    
                }
                
                Divider()
                    .background(Color .orange)
                
                Text("Elige el color de tu tarjeta")
                
                //Scroll horizontal para navegar entre las opciones de cambio de color de la tarjeta
                ScrollView(.horizontal){
                    HStack (spacing: 30) {
                        
                        Image(systemName: "arrow.right.to.line")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.orange)
                            .frame(width: 8, height: 50)
                            .padding(.leading, 100)
                        
                        //Se recorre el array con los colores
                        ForEach(colors, id: \.self) { color in
                            
                            ImageBoard(imageColor: color, color: $color)
                            
                        }
                        Image(systemName: "arrow.left.to.line")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.orange)
                            .frame(width: 8, height: 50)
                            .padding()
                    }
                }
                
                .background(Color.init("ColorForm"))
                Divider()
                    .background(Color .orange)
                
                VStack{
                    
                    //Condicion para mostrar la parte delantera de la tarjeta o la trasera
                    if expanded {
                        FrontCard(color: $color)
                            
                            .frame(minWidth: 200, idealWidth: 380, maxWidth: 450, minHeight: 150, idealHeight: 250, maxHeight: 300, alignment: .center)
                    }else{
                        BackCard(color: $color)
                            .frame(minWidth: 200, idealWidth: 380, maxWidth: 400, minHeight: 150, idealHeight: 250, maxHeight: 300, alignment: .center)
                    }
                }
                .rotation3DEffect(.degrees(expanded ? 0 : 180), axis: (x: 0, y: 1, z: 0 ))
                .cornerRadius(30)
                .padding(.top, 45)
                .frame( maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, 200)
                .shadow(color:.black, radius: 8)
                .padding(.horizontal)
                .rotation3DEffect(.degrees(expanded ? 0 : 180), axis: (x: 0, y: 1, z:0))
                .onTapGesture {
                    self.expanded.toggle()
                    
                }
                .background(Color.init("ColorForm"))
                .animation(.spring(dampingFraction: 0.5))
            }
        }.edgesIgnoringSafeArea(.all)
    }
}


//Vista de las opciones de los colores
struct ImageBoard : View {
    
    @State var expanded = true
    @State var imageColor = "Color2"
    @Binding var color : String //variable binding para recoger el valor del color seleccionado
    
    var body: some View {
        
        Color.init(imageColor)
            .scaledToFill()
            .frame(width: 45, height: 85)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color .black))
            .shadow(color:.orange, radius: 5)
            .rotation3DEffect(.degrees(expanded ? 0 : 360), axis: (x: 1, y: 1, z: 0))
            .onTapGesture {
                self.expanded.toggle()
                self.color = imageColor
                
            }
            .animation(.spring(dampingFraction: 0.5))
    }
}

//Vista frontal de la tarjeta
struct FrontCard : View {
    
    @EnvironmentObject var userInfo: UserInfo //Obtiene los datos de userInfo
    @Binding var color : String // variable binding para recoger el dato del color seleccionado
    
    var body: some View {
        
        ZStack{
            
            Color.init(color)
            HStack{
                
                //Condiciones para mostrar los campos con datos o sin datos
                if userInfo.name .isEmpty{
                    Text("?")
                        .font(.custom("Baskerville-Bold", fixedSize: 45))
                        .frame(width: 80, height: 90)
                        .background(Color .white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color .black))
                }else{
                    Text((userInfo.name.prefix(1)))
                        .font(.custom("Baskerville-Bold", fixedSize: 45))
                        .frame(width: 80, height: 90)
                        .background(Color .white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color .black))
                }
                
                
                VStack{
                    if userInfo.name .isEmpty && userInfo.surname .isEmpty{
                        Text("Sin datos")
                            .font(.custom("Baskerville-Bold", fixedSize: 30))
                        
                    }else{
                        Text("\(userInfo.name)" + " \(userInfo.surname)") .font(.custom("Baskerville-Bold", fixedSize: 30))
                        
                    }
                    
                    if userInfo.job .isEmpty{
                        Text("Sin datos")
                        
                    }else{
                        
                        Text("\(userInfo.job)")
                        
                    }
                }
            }
        }
    }
}

//Vista de la parte trasera de la tarjeta
struct BackCard : View{
    
    @EnvironmentObject var userInfo: UserInfo //Obtiene los datos de userInfo
    @Binding var color : String // variable binding para recoger el dato del color seleccionado
    
    var body: some View {
        ZStack{
            
            Color(color)
            VStack{
                HStack{
                    
                    //Se muestran los iconos de las secciones
                    VStack{
                        
                        Image(systemName: "phone.down.fill")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .frame(width: 2, height: 50, alignment: .trailing)
                            .padding(.leading, 50)
                        
                        
                        Image(systemName: "envelope.fill")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .frame(width: 2, height: 50, alignment: .trailing)
                            .padding(.leading, 50)
                        
                        
                        Image(systemName: "house.fill")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .frame(width: 2, height: 50, alignment: .trailing)
                            .padding(.leading, 50)
                        
                    }
                    
                    //Se muestran los datos de las secciones
                    VStack{
                        
                        //comprobacion el campo de telefono no este vacio
                        if userInfo.phone .isEmpty{
                            Text("Sin datos")
                                .frame(width: 200, height: 50, alignment: .leading)
                            
                            //comprobacion el campo de telefono no supere los 10 caracteres
                        }else if userInfo.phone .count > 10{
                            Text("Número no válido")
                                .frame(width: 200, height: 50, alignment: .leading)
                            
                        }else{
                            Text("\(userInfo.phone)")
                                .frame(width: 200, height: 50, alignment: .leading)
                            
                        }
                        
                        //comprobacion el campo de email no este vacio
                        if userInfo.email .isEmpty {
                            Text("Sin datos")
                                .frame(width: 200, height: 50, alignment: .leading)
                            
                            //comprobacion sea un correo valido(contenga una @)
                        }else if userInfo.email .contains("@"){
                            Text("\(userInfo.email)")
                                .frame(width: 200, height: 50, alignment: .leading)
                            
                        }else{
                            Text("Correo no válido")
                                .frame(width: 200, height: 50, alignment: .leading)
                        }
                        
                        //comprobacion el campo de adress no este vacio
                        if userInfo.adress .isEmpty{
                            Text("Sin datos")
                                .frame(width: 200, height: 50, alignment: .leading)
                            
                        }else{
                            Text("\(userInfo.adress)")
                                .frame(width: 200, height: 50, alignment: .leading)
                            
                        } 
                    }
                }
            }
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView( colors: ["Color", "Color1", "Color2", "Color3", "Color4", "Color5", "Color6", "Color7"])
        
    }
}

