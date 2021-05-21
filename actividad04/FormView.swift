
import SwiftUI
import Combine

class UserInfo: ObservableObject{
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var job: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var adress: String = ""
}

//Vista del formulario para introducir los datos de la tarjeta

struct FormView: View{
    
    //los campos de userInfo podran utilizarse desde otras vistas
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {

        VStack {
            
            //Imagen del header
            Image("trabajo")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 150)
            Spacer()
            
            //Titulo con el nombre de la app
            Text("CARDMAKER")
                .font(.custom("AmericanTypewriter-Light", fixedSize: 40))
                .bold()
                .foregroundColor(.orange)
                .padding()
            
            //Texto informativo
            Text("Introduce tus datos")
                .padding(5)
                .foregroundColor(.orange)
            
            //Formulario Con todos los campos
            Form {
                
                //Campos para introducir los datos personales(datos principales)
                Section(header: Text("DATOS PERSONALES")){
                    TextField("Nombre*", text: $userInfo.name)
                    TextField("Apellido*", text: $userInfo.surname)
                    TextField("Puesto de trabajo*", text: $userInfo.job)
                    
                    Color.orange
                        .frame(maxWidth: .infinity, maxHeight: 7)
                }
            
                //Campos para introducir los datos de contacto(datos secundarios)
                Section(header: Text("DATOS DE CONTACTO")){
                    
                    TextField("Número de teléfono*", text: $userInfo.phone)
                        //Configuracion para que el campo numero de telefono solo admita numeros
                        .keyboardType(.numberPad)
                        .onReceive(Just(userInfo.phone)){ newValue in
                            let filtered = newValue.filter
                            { "0123456789".contains($0)}
                            if filtered != newValue{
                                self.userInfo.phone = filtered
                            }
                            
                        }
                    
                    TextField("Correo electrónico*", text: $userInfo.email)
                    TextField("Dirección*", text: $userInfo.adress)
                    
                    Color.orange
                        .frame(maxWidth: .infinity, maxHeight: 7)
                }
            }
        }.background(Color .init("ColorForm"))
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
