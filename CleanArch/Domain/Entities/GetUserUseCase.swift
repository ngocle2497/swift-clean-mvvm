import Foundation

protocol GetUserUseCase {
    func execute(completion: @escaping (Result<User, Error>) -> Void)
}

final class GetUserUseCaseImpl: GetUserUseCase {
    
//    private let userRepository: 
    
    func execute(completion: @escaping (Result<User, any Error>) -> Void) {
        
    }
    
    
}
