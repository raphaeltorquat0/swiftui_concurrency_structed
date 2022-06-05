import SwiftUI
import OSLog

class MarsData {
    let marsRoversAPI = MarsRoverAPI()
    
    func fetchAllRovers() async -> [Rover] {
        do {
            return try await marsRoversAPI.allRovers()
        } catch {
            log.error("Error fetching rovers:\(String(describing: error))")
            return []
        }
    }
    
    func fetchLatestPhotos() async -> [Photo] {
        await withTaskGroup(of: Photo?.self) { group in
            let rovers = await fetchAllRovers()
            
            for rover in rovers {
                group.addTask {
                    let photos = try? await self.marsRoversAPI.latestPhotos(rover: rover)
                    return photos?.first
                }
            }
            var latestPhotos: [Photo] = []
            for await result in group {
                if let photo = result {
                    latestPhotos.append(photo)
                }
            }
            return latestPhotos
        }
    }
    
    func fetchPhotoManifest()  async throws -> [PhotoManifest] {
        let api = marsRoversAPI
        return try await withThrowingTaskGroup(of: PhotoManifest.self) { group in
            let rovers = await fetchAllRovers()
            try Task.checkCancellation()
            for rover in rovers {
                group.addTask {
                    return try await api.photoManifest(rover: rover)
                }
            }
            return try await group.reduce(into:[]) { manifestArray, manifest in
                manifestArray.append(manifest)
            }
        }
    }
    
    func fetchPhotos(roverName: String, sol: Int) async -> [Photo] {
        do {
            return try await marsRoversAPI.photos(roverName: roverName, sol: sol)
        } catch {
            log.error("Error fetching rover photos: \(String(describing: error))")
            return []
        }
    }
}
