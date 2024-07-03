import SwiftUI

struct FilterMenuBar: View {
    @State private var searchResults = [SearchResult]()
    @EnvironmentObject var filterState : FilterStateViewModel
    
    var body: some View {
        HStack {
            
            HStack{
                Text("Active")
                    .font(.system(size: 12))
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.red)
            }
            Spacer()
            
            HStack{
                Text("Entertainment")
                    .font(.system(size: 12))
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.blue)
            }
            Spacer()
            
            
            HStack{
                Text("Eat/Drink")
                    .font(.system(size: 12))
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.orange)
            }
            Spacer()
            
            
            HStack{
                Text("Anything")
                    .font(.system(size: 12))
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.green)
            }
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(uiColor: .systemBackground))
                .tint(Color(uiColor: .secondaryLabel))
        }
    }
}

#Preview {
    FilterMenuBar()
}
