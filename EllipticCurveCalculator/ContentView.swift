import SwiftUI
import SafariServices

struct ContentView: View {
    @State private var selectedOption = 0
    @State private var result = ""
    @State private var showingInfo = false
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $selectedOption) {
                PointAdditionView(result: $result)
                    .tabItem {
                        Image(systemName: "plus.circle")
                        Text("Point Addition")
                    }
                    .onTapGesture {
                        result = ""
                    }
                    .tag(0)
                
                ScalarMultiplicationView(result: $result)
                    .tabItem {
                        Image(systemName: "multiply.circle")
                        Text("Scalar Multiplication")
                    }
                    .onTapGesture {
                        result = ""
                    }
                    .tag(1)
            }
            .transition(.slide)
            .navigationBarTitle("ECO3000")
            .navigationBarItems(trailing:
                                    Button(action: {
                showingInfo = true
            }) {
                Image(systemName: "info.circle")
            }
            )
            .sheet(isPresented: $showingInfo) {
                InfoView()
            }
            .padding()
        }
    }
    
    struct InfoView: View {
        @State private var isShowingSafariView = false

        var body: some View {
            VStack {
                Text("About ECO3000")
                    .font(.title)
                    .padding()
                Button(action: {
                    isShowingSafariView = true
                }) {
                    Image("Iconos")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding()
                }
                HStack{
                    Text("Built with")
                        .font(.headline)
                    
                    Image(systemName: "heart.fill")
                        .font(.system(size: 40))
                }
            }
            .navigationTitle("About")
            .sheet(isPresented: $isShowingSafariView) {
                SafariView(url: URL(string: "https://intron014.com")!) 
            }
        }
    }
    
    struct SafariView: UIViewControllerRepresentable {
        let url: URL
        
        func makeUIViewController(context: Context) -> SFSafariViewController {
            return SFSafariViewController(url: url)
        }
        
        func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
            
        }
    }
}
