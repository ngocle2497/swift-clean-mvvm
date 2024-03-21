import Foundation

final class UserRepositoriesImpl {
    
}

extension UserRepositoriesImpl: UserRepository {
    func getUserList(page: Int, pageSize: Int, completion: @escaping (Result<UsersPage, any Error>) -> Void) {
        
    }
}
