import SwiftUI

struct LatestView: View {
    private let marsData = MarsData()
    @State private var latestPhotos: [Photo] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(latestPhotos) { photo in
                            MarsImageView(photo: photo)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                        }
                    }
                }
                if latestPhotos.isEmpty {
                    MarsProgressView()
                }
            }
            .navigationTitle("Latest Photos")
        }
        .task {
            latestPhotos = []
            latestPhotos = await marsData.fetchLatestPhotos()
        }
    }
}

struct LatestView_Previews: PreviewProvider {
    static var previews: some View {
        LatestView()
    }
}
