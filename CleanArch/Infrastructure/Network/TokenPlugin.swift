import Foundation
import Moya

class TokenPlugin: PluginType {
    private var isRefreshing = false
    private var requestQueue: [TargetType] = []
    
//    
//    func didReceive(_ result: Result<Response, MoyaError>, target: any TargetType) {
//        if case let .success(response) = result, response.statusCode == 401 {
//            refreshTokenAndRetry(target: target)
//        }
//    }
    
//    private func refreshTokenAndRetry(target: TargetType) {
//        guard !isRefreshing else {
//            return
//        }
//        // Set isRefreshing flag to true to avoid concurrent token refresh
//        isRefreshing = true
//        
//        tokenProvider.refreshToken { [weak self] refreshedToken in
//            guard let self = self else { return }
//            
//            // Update the token if refresh is successful
//            if let refreshedToken = refreshedToken {
//                self.tokenProvider.updateToken(refreshedToken)
//            } else {
//                // Handle token refresh failure (e.g., logout user)
//                // You can throw an error or perform any appropriate action here
//            }
//            
//            self.isRefreshing = false
//            self.retryRequest(target: target)
//        }
//    }
//    private func retryRequest(target: TargetType) {
//        provider.request(target) { [weak self] result in
//            // Handle the retry result if needed
//        }
//    }
    
}
