import SwiftUI

struct RoverManifestView: View {
    let manifest: PhotoManifest
    
    var body: some View {
        List(manifest.entries, id: \.sol) { entry in
            NavigationLink {
                RoverPhotosBySolListView(name: manifest.name, sol: entry.sol)
            } label: {
                HStack {
                    Text("Sol \(entry.sol) (\(Text.marsDateText(dateString: entry.earthDate))")
                    Spacer()
                    Text("\(entry.totalPhotos) \(Image(systemName: "photo"))")
                }
            }
        }
        .navigationTitle(manifest.name)
    }
}

struct RoverManifestView_Previews: PreviewProvider {
    static var previews: some View {
        RoverManifestView(manifest:
        PhotoManifest(
            name: "WALL-E",
            landingDate: "2021-12-31",
            launchDate: "2021-12-01",
            status: "active",
            maxSol: 31,
            maxDate: "2022-01-31",
            totalPhotos: 333, entries: [
                ManifestEntry(sol: 1, earthDate: "2022-01-01", totalPhotos: 0, cameras: []),
                ManifestEntry(sol: 2, earthDate: "2022-01-02", totalPhotos: 30, cameras: []),
                ManifestEntry(sol: 3, earthDate: "2022-01-03", totalPhotos: 300, cameras: []),
            ]
        )
      )
    }
}
