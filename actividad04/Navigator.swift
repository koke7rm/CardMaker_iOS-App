
import SwiftUI

//preparando navegacion entre vistas
struct Navigator: View {
    
    //Se declara el array de colores para poder ser utilizado desde cualquier vista que este dentro del Navigator
    var colors = ["Color", "Color1", "Color2", "Color3", "Color4", "Color5", "Color6", "Color7"]
    
    var body: some View {
        
        TabView {
            //Vista del formulario
            FormView()
                .tabItem {
                    Image(systemName: "doc.plaintext")
                    Text("Crear tarjeta")
                }
            
            //Vista de la tarjeta personalizada
            CardView(colors: colors)
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Vista tarjeta")
                }
        }
    }
}

struct NavigatorExampleView_Previews: PreviewProvider {
    static var previews: some View {
        Navigator()
    }
}
