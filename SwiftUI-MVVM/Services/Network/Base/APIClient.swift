//
//  APIClient.swift
//  SwiftUI-MVVM
//
//  Created by Dmitrii Ziablikov on 08.01.2020.
//  Copyright © 2020 Dmitrii Ziablikov. All rights reserved.
//

import Apollo
import Foundation

final class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    private lazy var networkTransport = HTTPNetworkTransport(
        url: URL(string: "http://localhost:4000")!,
        delegate: self
    )
    
    private(set) lazy var apollo = ApolloClient(networkTransport: self.networkTransport)
    //private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:4000")!)
}

// MARK: - Pre-flight delegate

extension APIClient: HTTPNetworkTransportPreflightDelegate {

    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          shouldSend request: URLRequest) -> Bool {
        // If there's an authenticated user, send the request. If not, don't.
        return UserManager.shared.isAuthorized
    }

    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          willSend request: inout URLRequest) {

        // Get the existing headers, or create new ones if they're nil
        var headers = request.allHTTPHeaderFields ?? [String: String]()

        // Add any new headers you need
        headers["Authorization"] = "Bearer \(UserManager.shared.currentAuthToken)"

        // Re-assign the updated headers to the request.
        request.allHTTPHeaderFields = headers

        Logger.log(.debug, "Outgoing request: \(request)")
    }
}

// MARK: - Task Completed Delegate

extension APIClient: HTTPNetworkTransportTaskCompletedDelegate {
    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          didCompleteRawTaskForRequest request: URLRequest,
                          withData data: Data?,
                          response: URLResponse?,
                          error: Error?) {
        Logger.log(.debug, "Raw task completed for request: \(request)")

        if let error = error {
            Logger.log(.error, "Error: \(error)")
        }

        if let response = response {
            Logger.log(.debug, "Response: \(response)")
        } else {
            Logger.log(.error, "No URL Response received!")
        }

        if let data = data {
            Logger.log(.debug, "Data: \(String(describing: String(bytes: data, encoding: .utf8)))")
        } else {
            Logger.log(.error, "No data received!")
        }
    }
}

// MARK: - Retry Delegate

extension APIClient: HTTPNetworkTransportRetryDelegate {
    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          receivedError error: Error,
                          for request: URLRequest,
                          response: URLResponse?,
                          retryHandler: @escaping (_ shouldRetry: Bool) -> Void) {
        // Check if the error and/or response you've received are something that requires authentication
//        guard UserManager.shared.requiresReAuthentication(basedOn: error, response: response) else {
//            // This is not something this application can handle, do not retry.
            retryHandler(false)
//            return
//        }

        // Attempt to re-authenticate asynchronously
//        UserManager.shared.reAuthenticate { success in
//            // If re-authentication succeeded, try again. If it didn't, don't.
//            retryHandler(success)
//        }
    }
}
